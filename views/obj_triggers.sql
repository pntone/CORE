CREATE OR REPLACE VIEW obj_triggers AS
WITH x AS (
    SELECT
        app.get_app_id()                AS app_id,
        app.get_item('$TABLE_NAME')     AS table_name,
        app.get_item('$TRIGGER_NAME')   AS trigger_name,
        app.get_date_item('G_TODAY')    AS today
    FROM users u
    WHERE u.user_id = app.get_user_id()
),
r AS (
    SELECT /* materialize */
        l.action_name       AS table_name,
        COUNT(l.log_id)                                                                     AS count_calls,
        SUM(TO_NUMBER(REGEXP_SUBSTR(l.arguments, '"inserted":"?(\d+)', 1, 1, NULL, 1)))     AS count_inserted,
        SUM(TO_NUMBER(REGEXP_SUBSTR(l.arguments, '"updated":"?(\d+)',  1, 1, NULL, 1)))     AS count_updated,
        SUM(TO_NUMBER(REGEXP_SUBSTR(l.arguments, '"deleted":"?(\d+)',  1, 1, NULL, 1)))     AS count_deleted
    FROM x
    JOIN logs l
        ON l.created_at     >= x.today
        AND l.created_at    < x.today + 1
        AND l.app_id        = x.app_id
        AND l.flag          = 'G'
        AND l.action_name   = NVL(x.table_name, l.action_name)
    GROUP BY l.action_name
)
SELECT
    t.table_name,
    g.trigger_name,
    --
    CASE
        WHEN g.trigger_name         = t.table_name || '__'          -- default trigger name
            AND g.trigger_type      = 'COMPOUND'
            AND g.triggering_event  = 'INSERT OR UPDATE OR DELETE'
            AND g.before_statement  = 'YES'
            AND g.before_row        = 'YES'
            AND g.after_row         = 'YES'
            AND g.after_statement   = 'YES'
            AND g.status            = 'ENABLED'
        THEN 'Y'
        END AS is_valid,
    --
    r.count_calls,
    r.count_inserted,
    r.count_updated,
    r.count_deleted,
    --
    o.last_ddl_time
FROM user_tables t
CROSS JOIN x
LEFT JOIN user_triggers g
    ON g.table_name     = t.table_name
LEFT JOIN user_objects o
    ON o.object_name    = g.trigger_name
LEFT JOIN user_mviews v
    ON v.mview_name     = t.table_name
LEFT JOIN r
    ON r.table_name     = g.table_name
WHERE t.table_name      = NVL(x.table_name, t.table_name)
    AND t.table_name    NOT LIKE '%\_%$' ESCAPE '\'
    AND v.mview_name    IS NULL;
