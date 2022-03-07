CREATE OR REPLACE VIEW obj_modules AS
WITH x AS (
    SELECT /*+ MATERIALIZE */
        app.get_owner()                             AS owner,
        app.get_item('$PACKAGE_NAME')               AS package_name,
        app.get_item('$MODULE_NAME')                AS module_name,
        app.get_item('$MODULE_TYPE')                AS module_type,
        app.get_item('$ARGUMENT_NAME')              AS argument_name,
        --
        UPPER(app.get_item('$SEARCH_PACKAGES'))     AS search_packages,
        UPPER(app.get_item('$SEARCH_MODULES'))      AS search_modules,
        UPPER(app.get_item('$SEARCH_ARGUMENTS'))    AS search_arguments,
        LOWER(app.get_item('$SEARCH_SOURCE'))       AS search_source
    FROM DUAL
),
i AS (
    -- find modules and start lines in spec and body
    SELECT /*+ MATERIALIZE */
        i.owner,
        i.object_name,
        i.object_type,
        i.name                  AS module_name,
        i.type                  AS module_type,
        i.line                  AS start_line,
        --
        LEAD(i.line) OVER (PARTITION BY i.object_name, i.object_type ORDER BY p.subprogram_id, i.line) - 1      AS end_line,
        ROW_NUMBER() OVER (PARTITION BY i.object_name, i.object_type, p.subprogram_id ORDER BY p.subprogram_id) AS overload_check,
        --
        NVL(p.overload, 1)      AS overload,
        p.subprogram_id,
        p.authid,
        p.result_cache
    FROM all_identifiers i
    JOIN x
        ON x.owner              = i.owner
    JOIN all_source s
        ON s.owner              = i.owner
        AND s.name              = i.object_name
        AND s.type              = i.object_type
        AND s.line              = i.line
    JOIN all_procedures p                           -- only public procedures
        ON p.owner              = i.owner
        AND p.object_name       = i.object_name
        AND p.procedure_name    = i.name
    WHERE i.type                IN ('PROCEDURE', 'FUNCTION')
        AND i.object_type       IN ('PACKAGE', 'PACKAGE BODY')
        AND i.usage             = CASE s.type WHEN 'PACKAGE BODY' THEN 'DEFINITION' ELSE 'DECLARATION' END
),
p AS (
    SELECT /*+ MATERIALIZE */
        i.*
    FROM i
    JOIN i f
        ON f.object_name        = i.object_name
        AND f.object_type       = i.object_type
        AND f.module_name       = i.module_name
        AND f.overload          = i.overload
        AND f.overload_check    = i.overload_check
        AND f.overload          = f.overload_check
    JOIN x
        ON i.object_name        = NVL(x.package_name, i.object_name)
        AND (i.object_name      LIKE x.search_packages || '%' ESCAPE '\' OR x.search_packages IS NULL)
),
s AS (
    SELECT /*+ MATERIALIZE */
        s.name,
        s.type,
        s.line,
        s.text,
        CASE WHEN LOWER(s.text) LIKE '%' || x.search_source || '%' ESCAPE '\' THEN 'Y' END AS is_found_text
    FROM all_source s
    JOIN x
        ON x.owner      = s.owner
        AND s.name      = NVL(x.package_name, s.name)
        AND (s.name     LIKE x.search_packages || '%' ESCAPE '\' OR x.search_packages IS NULL)
),
e AS (
    -- find ending lines
    SELECT /*+ MATERIALIZE */
        s.name,
        s.type,
        s.line
    FROM s
    WHERE (
        (s.type = 'PACKAGE BODY' AND REGEXP_LIKE(UPPER(s.text), '^\s*END(\s+[A-Z0-9_]+)?\s*;')) OR
        (s.type = 'PACKAGE'      AND REGEXP_LIKE(UPPER(s.text), ';'))
    )
),
t AS (
    -- calculate module start and end lines
    SELECT /*+ MATERIALIZE */
        p.owner,
        p.object_name       AS package_name,
        p.module_name,
        p.module_type,
        p.subprogram_id,
        p.overload,
        p.authid,
        p.result_cache,
        --
        MIN(CASE p.object_type WHEN 'PACKAGE'       THEN p.start_line END)              AS spec_start,
        MIN(CASE p.object_type WHEN 'PACKAGE'       THEN e.line END)                    AS spec_end,
        MIN(CASE p.object_type WHEN 'PACKAGE'       THEN e.line - p.start_line + 1 END) AS spec_lines,
        MAX(CASE p.object_type WHEN 'PACKAGE BODY'  THEN p.start_line END)              AS body_start,
        MAX(CASE p.object_type WHEN 'PACKAGE BODY'  THEN e.line END)                    AS body_end,
        MAX(CASE p.object_type WHEN 'PACKAGE BODY'  THEN e.line - p.start_line + 1 END) AS body_lines
    FROM p
    LEFT JOIN e
        ON e.name       = p.object_name
        AND e.type      = p.object_type
        AND e.line      BETWEEN p.start_line AND NVL(p.end_line, 999999)
    GROUP BY p.owner, p.object_name, p.module_name, p.module_type, p.subprogram_id, p.overload, p.authid, p.result_cache
),
a AS (
    -- arguments
    SELECT /*+ MATERIALIZE */
        t.package_name,
        t.module_name,
        t.module_type,
        t.subprogram_id,
        --
        NULLIF(SUM(CASE WHEN a.in_out LIKE 'IN%' THEN 1 ELSE 0 END), 0)                             AS args_in,
        NULLIF(SUM(CASE WHEN a.in_out LIKE '%OUT' AND position > 0 THEN 1 ELSE 0 END), 0)           AS args_out,
        MAX(CASE WHEN (a.argument_name LIKE x.search_arguments || '%' ESCAPE '\') THEN 'Y' END)     AS is_arg_present,
        MAX(CASE WHEN a.argument_name = x.argument_name THEN 'Y' END)                               AS is_arg_match
    FROM t
    CROSS JOIN x
    LEFT JOIN all_arguments a
        ON a.owner              = x.owner
        AND a.package_name      = t.package_name
        AND a.object_name       = t.module_name
        AND a.subprogram_id     = t.subprogram_id
    GROUP BY t.package_name, t.module_name, t.module_type, t.subprogram_id
),
d AS (
    -- documentation lines
    SELECT /*+ MATERIALIZE */
        d.package_name, d.module_name, d.module_type, d.subprogram_id, --s.line, s.text
        LISTAGG(REGEXP_SUBSTR(s.text, '^\s*--\s*(.*)\s*$', 1, 1, NULL, 1), '<br />') WITHIN GROUP (ORDER BY s.line) AS comment_,
        MIN(s.line) AS doc_start
    FROM (
        SELECT
            t.package_name, t.module_name, t.module_type, t.subprogram_id,
            MAX(s.line) + 1     AS doc_start,
            t.spec_start - 1    AS doc_end
        FROM t
        LEFT JOIN s
            ON s.name       = t.package_name
            AND s.type      = 'PACKAGE'
            AND s.line      < t.spec_start
            AND REGEXP_LIKE(s.text, '^\s*$')
        GROUP BY t.package_name, t.module_name, t.module_type, t.subprogram_id, t.spec_start
    ) d
    LEFT JOIN s
        ON s.name           = d.package_name
        AND s.type          = 'PACKAGE'
        AND s.line          BETWEEN d.doc_start AND d.doc_end
        AND NOT REGEXP_LIKE(s.text, '^\s*--\s*$')
    GROUP BY d.package_name, d.module_name, d.module_type, d.subprogram_id
),
g AS (
    -- group for related modules
    SELECT /*+ MATERIALIZE */
        s.name,
        s.line,
        RTRIM(REGEXP_REPLACE(s.text, '^\s*--\s*###\s*', ''))    AS group_name,
        RPAD(' ', ROW_NUMBER() OVER(ORDER BY s.line DESC))      AS group_sort
    FROM all_source s
    JOIN x
        ON x.owner          = s.owner
        AND s.name          = NVL(x.package_name, s.name)
        AND (s.name         LIKE x.search_packages || '%' ESCAPE '\' OR x.search_packages IS NULL)
    WHERE s.type            = 'PACKAGE'
        AND REGEXP_LIKE(s.text, '^\s*--\s*###')
),
f AS (
    -- search source code
    SELECT /*+ MATERIALIZE */
        t.package_name,
        t.module_name,
        t.subprogram_id
    FROM t
    JOIN s
        ON s.name           = t.package_name
        AND s.type          = 'PACKAGE BODY'
        AND s.line          BETWEEN t.body_start AND t.body_end
        AND s.is_found_text = 'Y'
    GROUP BY t.package_name, t.module_name, t.subprogram_id
),
q AS (
    -- search statements
    SELECT /*+ MATERIALIZE */
        t.package_name,
        t.module_name,
        t.subprogram_id,
        --
        --s.type,  -- SELECT, INSERT, UPDATE, DELETE, MERGE, EXECUTE IMMEDIATE, FETCH, OPEN, CLOSE, COMMIT, ROLLBACK
        --
        COUNT(*)            AS count_statements
    FROM t
    JOIN all_statements s
        ON s.owner          = t.owner
        AND s.object_name   = t.package_name
        AND s.object_type   = 'PACKAGE BODY'
        AND s.line          BETWEEN t.body_start AND t.body_end
    GROUP BY t.package_name, t.module_name, t.subprogram_id
)
SELECT
    t.package_name,
    t.module_name,
    --
    (
        SELECT MIN(g.group_sort || g.group_name) KEEP (DENSE_RANK FIRST ORDER BY g.line DESC) AS group_name
        FROM g
        WHERE g.name        = t.package_name
            AND g.line      < t.spec_start
    ) AS group_name,
    --
    t.overload,
    --
    CASE WHEN t.module_type = 'FUNCTION'    THEN 'Y' END AS is_function,
    CASE WHEN b.text IS NOT NULL            THEN 'Y' END AS is_private,
    CASE WHEN n.text IS NOT NULL            THEN 'Y' END AS is_autonomous,
    CASE WHEN t.result_cache = 'YES'        THEN 'Y' END AS is_cached,
    CASE WHEN t.authid = 'DEFINER'          THEN 'Y' END AS is_definer,
    --
    a.args_in,
    a.args_out,
    --
    t.spec_start,
    t.spec_end,
    t.spec_lines,
    t.body_start,
    t.body_end,
    t.body_lines            AS count_lines,
    --
    q.count_statements,
    --
    d.comment_
FROM t
JOIN x
    ON t.package_name                   = NVL(x.package_name, t.package_name)
    AND t.module_name                   = NVL(x.module_name, t.module_name)
    AND SUBSTR(t.module_type, 1, 1)     = NVL(x.module_type, SUBSTR(t.module_type, 1, 1))
    --
    AND (t.package_name LIKE x.search_packages || '%' ESCAPE '\'    OR x.search_packages    IS NULL)
    AND (t.module_name  LIKE x.search_modules  || '%' ESCAPE '\'    OR x.search_modules     IS NULL)
JOIN a
    ON a.package_name       = t.package_name
    AND a.module_name       = t.module_name
    AND a.subprogram_id     = t.subprogram_id
    AND (a.is_arg_present   = 'Y' OR x.search_arguments IS NULL)
    AND (a.is_arg_match     = 'Y' OR x.argument_name IS NULL)
JOIN d
    ON d.package_name       = t.package_name
    AND d.module_name       = t.module_name
    AND d.subprogram_id     = t.subprogram_id
LEFT JOIN s b
    ON b.name               = t.package_name
    AND b.type              = 'PACKAGE'
    AND b.line              BETWEEN t.spec_start AND t.spec_end
    AND REGEXP_LIKE(b.text, '^\s*(ACCESSIBLE BY)')
LEFT JOIN s n
    ON n.name               = t.package_name
    AND n.type              = 'PACKAGE BODY'
    AND n.line              BETWEEN t.body_start AND t.body_end
    AND REGEXP_LIKE(n.text, 'PRAGMA\s+AUTONOMOUS_TRANSACTION')
LEFT JOIN f
    ON f.package_name       = t.package_name
    AND f.module_name       = t.module_name
    AND f.subprogram_id     = t.subprogram_id
LEFT JOIN q
    ON q.package_name       = t.package_name
    AND q.module_name       = t.module_name
    AND q.subprogram_id     = t.subprogram_id
WHERE (f.module_name IS NOT NULL OR x.search_source IS NULL);
--
COMMENT ON TABLE obj_modules                    IS 'Find package modules (procedures and functions) and their boundaries (start-end lines)';
--
COMMENT ON COLUMN obj_modules.package_name      IS 'Package name';
COMMENT ON COLUMN obj_modules.module_name       IS 'Module name';
COMMENT ON COLUMN obj_modules.group_name        IS 'Group name to have similar modules grouped together';
COMMENT ON COLUMN obj_modules.overload          IS 'Overload ID';
COMMENT ON COLUMN obj_modules.is_function       IS 'Module type (function)';
COMMENT ON COLUMN obj_modules.is_private        IS 'Flag for private procedures';
COMMENT ON COLUMN obj_modules.is_autonomous     IS 'Contains autonomous transaction';
COMMENT ON COLUMN obj_modules.is_cached         IS 'Has RESULT_CACHE activated';
COMMENT ON COLUMN obj_modules.is_definer        IS 'Auth as definer';
COMMENT ON COLUMN obj_modules.args_in           IS 'Number of IN arguments';
COMMENT ON COLUMN obj_modules.args_out          IS 'Number of OUT arguments';
COMMENT ON COLUMN obj_modules.spec_start        IS 'Module start in specification';
COMMENT ON COLUMN obj_modules.spec_end          IS 'Module end in specification';
COMMENT ON COLUMN obj_modules.spec_lines        IS 'Lines in specification';
COMMENT ON COLUMN obj_modules.body_start        IS 'Module start in body';
COMMENT ON COLUMN obj_modules.body_end          IS 'Module end in body';
COMMENT ON COLUMN obj_modules.count_lines       IS 'Lines in body';
COMMENT ON COLUMN obj_modules.comment_          IS 'Description from package spec';

