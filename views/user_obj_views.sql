CREATE OR REPLACE VIEW user_obj_views AS
WITH x AS (
    SELECT
        app.get_app_id()            AS app_id,
        app.get_item('$VIEW_NAME')  AS view_name
    FROM users u
    WHERE u.user_id = app.get_user_id()
),
r AS (
    SELECT
        d.name                  AS view_name,
        --
        LISTAGG(CASE WHEN d.referenced_type = 'TABLE' THEN d.referenced_name END, ', ') WITHIN GROUP (ORDER BY d.referenced_name) AS referenced_tables,
        LISTAGG(CASE WHEN d.referenced_type = 'VIEW'  THEN d.referenced_name END, ', ') WITHIN GROUP (ORDER BY d.referenced_name) AS referenced_views
    FROM user_dependencies d
    CROSS JOIN x
    WHERE d.type                = 'VIEW'
        AND d.name              = NVL(x.view_name, d.name)
    GROUP BY d.name
),
u AS (
    SELECT
        d.referenced_name                                       AS view_name,
        LISTAGG(d.name, ', ') WITHIN GROUP (ORDER BY d.name)    AS used_in_objects
    FROM user_dependencies d
    WHERE d.referenced_type     = 'VIEW'
    GROUP BY d.referenced_name
),
p AS (
    SELECT
        r.table_name,
        LISTAGG(DISTINCT '<a href="' || app.get_page_link(r.page_id) || '">' || r.page_id || '</a>', ', ') WITHIN GROUP (ORDER BY r.page_id) AS used_on_pages
        --LISTAGG(DISTINCT r.page_id, ', ') WITHIN GROUP (ORDER BY r.page_id) AS used_on_pages
    FROM apex_application_page_regions r
    JOIN x
        ON x.app_id             = r.application_id
    WHERE r.query_type_code     = 'TABLE'
    GROUP BY r.table_name
)
SELECT
    REGEXP_REPLACE(REGEXP_SUBSTR(v.view_name, '^[^_]+'), '^P\d+$', 'PAGE#') AS view_group,
    v.view_name,
    --
    u.used_in_objects,
    p.used_on_pages,
    r.referenced_tables,
    r.referenced_views,
    --
    NULLIF(v.read_only, 'N') AS is_readonly,
    --
    CASE WHEN v.bequeath = 'DEFINER' THEN 'Y' END AS is_definer,
    --
    o.last_ddl_time
FROM user_views v
JOIN user_objects o
    ON o.object_name            = v.view_name
    AND o.object_type           = 'VIEW'
CROSS JOIN x
LEFT JOIN r
    ON r.view_name              = v.view_name
LEFT JOIN u
    ON u.view_name              = v.view_name
LEFT JOIN p
    ON p.table_name             = v.view_name
WHERE v.view_name               = NVL(x.view_name, v.view_name);
