CREATE OR REPLACE VIEW obj_modules AS
WITH p AS (
    SELECT
        i.object_name,
        i.object_type,
        i.name              AS module_name,
        i.type              AS module_type,
        i.line                                                                                  AS start_line,
        LEAD(i.line) OVER (PARTITION BY i.object_name, i.object_type ORDER BY i.line) - 1       AS end_line,
        ROW_NUMBER() OVER (PARTITION BY i.object_name, i.object_type, i.name ORDER BY i.line)   AS overload
    FROM user_identifiers i
    JOIN user_source s
        ON s.name           = i.object_name
        AND s.type          = i.object_type
        AND s.line          = i.line
    WHERE i.type            IN ('PROCEDURE', 'FUNCTION')
        AND i.object_type   IN ('PACKAGE', 'PACKAGE BODY')
        AND i.usage         = CASE s.type WHEN 'PACKAGE BODY' THEN 'DEFINITION' ELSE 'DECLARATION' END
),
e AS (
    -- find ending lines
    SELECT s.*
    FROM user_source s
    WHERE (
        (s.type = 'PACKAGE BODY' AND REGEXP_LIKE(UPPER(s.text), '^\s*END(\s+[A-Z0-9_]+)?\s*;')) OR
        (s.type = 'PACKAGE'      AND REGEXP_LIKE(UPPER(s.text), ';'))
    )
),
t AS (
    -- calculate module start and end lines
    SELECT
        p.object_name AS package_name,
        p.module_name,
        p.module_type,
        CASE WHEN MAX(p.overload) OVER (PARTITION BY p.object_name, p.module_name) > 1 THEN p.overload END AS overload,
        --
        MIN(CASE p.object_type WHEN 'PACKAGE'       THEN p.start_line END)              AS spec_start,
        MIN(CASE p.object_type WHEN 'PACKAGE'       THEN e.line END)                    AS spec_end,
        MIN(CASE p.object_type WHEN 'PACKAGE'       THEN e.line - p.start_line + 1 END) AS spec_lines,
        MAX(CASE p.object_type WHEN 'PACKAGE BODY'  THEN p.start_line END)              AS body_start,
        MAX(CASE p.object_type WHEN 'PACKAGE BODY'  THEN e.line END)                    AS body_end,
        MAX(CASE p.object_type WHEN 'PACKAGE BODY'  THEN e.line - p.start_line + 1 END) AS body_lines
    FROM p
    LEFT JOIN e
        ON e.name   = p.object_name
        AND e.type  = p.object_type
        AND e.line  BETWEEN p.start_line AND NVL(p.end_line, 999999)
    GROUP BY p.object_name, p.module_name, p.module_type, p.overload
),
g AS (
    -- add module arguments
    SELECT
        t.package_name,
        t.module_name,
        t.module_type,
        t.overload,
        LISTAGG(a.argument_name || ' ' || a.in_out, ', ') WITHIN GROUP (ORDER BY a.position) AS args
    FROM t
    JOIN user_arguments a
        ON a.package_name   = t.package_name
        AND a.object_name   = t.module_name
        AND a.overload      = NVL(t.overload, 1)
        AND a.position      > 0
    GROUP BY t.package_name, t.module_name, t.module_type, t.overload
),
a AS (
    SELECT
        a.package_name,
        a.object_name                                                                           AS module_name,
        MIN(CASE WHEN a.in_out = 'OUT' AND a.position = 0 THEN 'FUNCTION' ELSE 'PROCEDURE' END) AS module_type,
        a.overload,
        NULLIF(SUM(CASE WHEN a.in_out LIKE 'IN%'  THEN 1 ELSE 0 END), 0)                        AS args_in,
        NULLIF(SUM(CASE WHEN a.in_out LIKE '%OUT' AND position > 0 THEN 1 ELSE 0 END), 0)       AS args_out
    FROM user_arguments a
    GROUP BY a.package_name, a.object_name, a.overload
),
d AS (
    SELECT
        d.package_name, d.module_name, d.module_type, d.overload, --x.line, x.text
        LISTAGG(REGEXP_SUBSTR(x.text, '^\s*--\s*(.*)\s*$', 1, 1, NULL, 1), '<br />') WITHIN GROUP (ORDER BY x.line) AS comment_,
        MIN(x.line) AS doc_start
    FROM (
        SELECT
            t.package_name, t.module_name, t.module_type, t.overload,
            MAX(x.line) + 1     AS doc_start,
            t.spec_start - 1    AS doc_end
        FROM t
        LEFT JOIN user_source x
            ON x.name       = t.package_name
            AND x.type      = 'PACKAGE'
            AND x.line      < t.spec_start
            AND REGEXP_LIKE(x.text, '^\s*$')
        GROUP BY t.package_name, t.module_name, t.module_type, t.overload, t.spec_start
    ) d
    LEFT JOIN user_source x
        ON x.name       = d.package_name
        AND x.type      = 'PACKAGE'
        AND x.line      BETWEEN d.doc_start AND d.doc_end
        AND NOT REGEXP_LIKE(x.text, '^\s*--\s*$')
    GROUP BY d.package_name, d.module_name, d.module_type, d.overload
)
SELECT
    t.package_name,
    t.module_name,
    CASE WHEN t.module_type = 'FUNCTION' THEN 'Y' END AS is_function,
    t.overload,
    --
    t.spec_start,
    t.spec_end,
    t.spec_lines,
    t.body_start,
    t.body_end,
    t.body_lines,
    --
    CASE WHEN b.text IS NOT NULL THEN 'Y' END AS is_private,
    --
    a.args_in,
    a.args_out,
    d.comment_
FROM t
LEFT JOIN a
    ON a.package_name       = t.package_name
    AND a.module_name       = t.module_name
    AND a.module_type       = t.module_type
    AND NVL(a.overload, 1)  = NVL(t.overload, 1)
LEFT JOIN d
    ON d.package_name       = t.package_name
    AND d.module_name       = t.module_name
    AND d.module_type       = t.module_type
    AND NVL(d.overload, 1)  = NVL(t.overload, 1)
LEFT JOIN user_source b
    ON b.name       = t.package_name
    AND b.type      = 'PACKAGE'
    AND b.line      BETWEEN t.spec_start AND t.spec_end
    AND REGEXP_LIKE(b.text, '^\s*(ACCESSIBLE BY)');
--
COMMENT ON TABLE obj_modules                    IS 'Find package modules (procedures and functions) and their boundaries (start-end lines)';
--
COMMENT ON COLUMN obj_modules.package_name      IS 'Package name';
COMMENT ON COLUMN obj_modules.module_name       IS 'Module name';
COMMENT ON COLUMN obj_modules.is_function       IS 'Module type (function)';
COMMENT ON COLUMN obj_modules.overload          IS 'Overload ID';
COMMENT ON COLUMN obj_modules.spec_start        IS 'Module start in specification';
COMMENT ON COLUMN obj_modules.spec_end          IS 'Module end in specification';
COMMENT ON COLUMN obj_modules.spec_lines        IS 'Lines in specification';
COMMENT ON COLUMN obj_modules.body_start        IS 'Module start in body';
COMMENT ON COLUMN obj_modules.body_end          IS 'Module end in body';
COMMENT ON COLUMN obj_modules.body_lines        IS 'Lines in body';
COMMENT ON COLUMN obj_modules.is_private        IS 'Flag for private procedures';
COMMENT ON COLUMN obj_modules.args_in           IS 'Number of IN arguments';
COMMENT ON COLUMN obj_modules.args_out          IS 'Number of OUT arguments';
COMMENT ON COLUMN obj_modules.comment_          IS 'Description from package spec';

