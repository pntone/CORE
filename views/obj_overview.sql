CREATE OR REPLACE VIEW obj_overview AS
SELECT
    INITCAP(o.object_type)  AS object_type,
    COUNT(*)                AS count_objects,
    --
    CASE o.object_type
        WHEN 'TABLE'        THEN app.get_page_link(951)
        WHEN 'TRIGGER'      THEN app.get_page_link(952)
        WHEN 'VIEW'         THEN app.get_page_link(955)
        WHEN 'PACKAGE'      THEN app.get_page_link(960)
        WHEN 'JOB'          THEN app.get_page_link(905)
        ELSE NULL
        END AS page_link
FROM user_objects o
WHERE o.object_type NOT IN ('PACKAGE BODY', 'TABLE PARTITION')
GROUP BY o.object_type;

