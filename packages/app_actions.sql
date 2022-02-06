CREATE OR REPLACE PACKAGE BODY app_actions AS

    FUNCTION get_object_link (
        in_object_type          VARCHAR2    := NULL,
        in_object_name          VARCHAR2    := NULL
    )
    RETURN VARCHAR2
    AS
    BEGIN
        RETURN CASE in_object_type
            WHEN 'TABLE'        THEN app.get_page_url(951, 'P951_TABLE_NAME',   in_object_name)
            WHEN 'TRIGGER'      THEN app.get_page_url(952, 'P952_TRIGGER_NAME', in_object_name)
            WHEN 'VIEW'         THEN app.get_page_url(955, 'P955_VIEW_NAME',    in_object_name)
            WHEN 'PACKAGE'      THEN app.get_page_url(960, 'P960_PACKAGE_NAME', in_object_name)
            WHEN 'JOB'          THEN app.get_page_url(905, 'P905_JOB_NAME',     in_object_name)
            END;
    END;



    FUNCTION get_html_a (
        in_href                 VARCHAR2,
        in_name                 VARCHAR2,
        in_title                VARCHAR2    := NULL
    )
    RETURN VARCHAR2
    AS
    BEGIN
        RETURN '<a href="' || in_href || '" title="' || in_title ||'">' || in_name || '</a>';
    END;



    PROCEDURE create_auth_scheme (
        in_app_id           apex_application_authorization.application_id%TYPE,
        in_name             apex_application_authorization.authorization_scheme_name%TYPE
    )
    AS
        out_statement       VARCHAR2(32767);
    BEGIN
        app.log_module(in_app_id, in_name);
        --
        FOR c IN (
            SELECT
                a.owner                 AS p_owner,
                a.workspace_id          AS p_workspace_id,
                a.application_id        AS p_application_id,
                in_name                 AS p_name,
                r.api_compatibility     AS p_version,
                r.version_no            AS p_release,
                wwv_flow_id.next_val    AS p_id,
                --
                'RETURN a' || a.application_id || '.' || LOWER(in_name) || '() = ''Y'';' AS p_body
            FROM apex_release r
            JOIN apex_applications a
                ON a.application_id                     = in_app_id
            LEFT JOIN apex_application_authorization z
                ON z.application_id                     = a.application_id
                AND z.authorization_scheme_name         = in_name
            WHERE z.authorization_scheme_name           IS NULL
        ) LOOP
            out_statement := out_statement || 'BEGIN' || CHR(10);
            out_statement := out_statement || '    wwv_flow_api.component_begin (' || CHR(10);
            out_statement := out_statement || '         p_version_yyyy_mm_dd     => ''' || c.p_version || '''' || CHR(10);
            out_statement := out_statement || '        ,p_release                => ''' || c.p_release || '''' || CHR(10);
            out_statement := out_statement || '        ,p_default_workspace_id   => ' || c.p_workspace_id || CHR(10);
            out_statement := out_statement || '        ,p_default_application_id => ' || c.p_application_id || CHR(10);
            out_statement := out_statement || '        ,p_default_id_offset      => 0' || CHR(10);
            out_statement := out_statement || '        ,p_default_owner          => ''' || c.p_owner || '''' || CHR(10);
            out_statement := out_statement || '    );' || CHR(10);
            out_statement := out_statement || '    wwv_flow_api.create_security_scheme (' || CHR(10);
            out_statement := out_statement || '         p_id                     => wwv_flow_api.id(' || c.p_id || ')' || CHR(10);
            out_statement := out_statement || '        ,p_name                   => ''' || c.p_name || '''' || CHR(10);
            out_statement := out_statement || '        ,p_scheme_type            => ''NATIVE_FUNCTION_BODY''' || CHR(10);
            out_statement := out_statement || '        ,p_attribute_01           => wwv_flow_string.join(wwv_flow_t_varchar2(''' || REPLACE(c.p_body, '''', '''''') || '''))' || CHR(10);
            out_statement := out_statement || '        ,p_error_message          => ''ACCESS_DENIED''' || CHR(10);
            out_statement := out_statement || '        ,p_caching                => ''BY_USER_BY_PAGE_VIEW''' || CHR(10);
            out_statement := out_statement || '    );' || CHR(10);
            out_statement := out_statement || '    wwv_flow_api.component_end;' || CHR(10);
            out_statement := out_statement || 'END;' || CHR(10);
        END LOOP;
        --
        DBMS_OUTPUT.PUT_LINE(out_statement);
        --
        IF out_statement IS NOT NULL THEN
            EXECUTE IMMEDIATE out_statement;
        END IF;
        --
        app.log_success();
    EXCEPTION
    WHEN app.app_exception THEN
        RAISE;
    WHEN OTHERS THEN
        app.raise_error();
    END;



    PROCEDURE nav_remove_pages (
        in_page_id              navigation.page_id%TYPE         := NULL
    )
    AS
    BEGIN
        app.log_module(in_page_id);

        -- remove references
        FOR c IN (
            SELECT n.app_id, n.page_id
            FROM navigation n
            JOIN nav_pages_to_remove p
                ON p.page_id        = n.parent_id
                AND n.page_id       = NVL(in_page_id, n.page_id)
            WHERE n.app_id          = app.get_app_id()
        ) LOOP
            app.log_debug('REMOVING_PARENT', c.page_id);
            --
            UPDATE navigation n
            SET n.parent_id         = NULL
            WHERE n.app_id          = c.app_id
                AND n.page_id       = c.page_id;
        END LOOP;

        -- remove rows for pages which dont exists
        FOR c IN (
            SELECT p.page_id
            FROM nav_pages_to_remove p
            WHERE p.page_id         = NVL(in_page_id, p.page_id)
        ) LOOP
            app.log_debug('DELETING', c.page_id);
            --
            DELETE FROM navigation n
            WHERE n.app_id          = app.get_app_id()
                AND n.page_id       = c.page_id;
        END LOOP;
        --
        app.log_success();
    END;



    PROCEDURE nav_add_pages (
        in_page_id              navigation.page_id%TYPE         := NULL
    )
    AS
        rec         navigation%ROWTYPE;
    BEGIN
        app.log_module(in_page_id);

        -- add pages which are present in APEX but missing in Navigation table
        FOR c IN (
            SELECT n.*
            FROM nav_pages_to_add n
            WHERE n.page_id = NVL(in_page_id, n.page_id)
        ) LOOP
            app.log_debug('ADDING', c.page_id);
            --
            rec.app_id      := c.app_id;
            rec.page_id     := c.page_id;
            rec.parent_id   := c.parent_id;
            rec.order#      := c.order#;
            rec.is_hidden   := c.is_hidden;
            rec.is_reset    := c.is_reset;
            --
            INSERT INTO navigation VALUES rec;
        END LOOP;
        --
        app.log_success();
    END;



    PROCEDURE nav_autoupdate
    AS
    BEGIN
        app.log_module();
        --
        nav_remove_pages();
        nav_add_pages();

        -- renumber sublings
        MERGE INTO navigation g
        USING (
            SELECT n.app_id, n.page_id, n.new_order#
            FROM (
                SELECT
                    n.app_id,
                    n.page_id,
                    n.order#,
                    ROW_NUMBER() OVER (PARTITION BY n.parent_id ORDER BY n.order#, n.page_id) * 5 + 5 AS new_order#
                FROM navigation n
                WHERE n.app_id          = app.get_app_id()
                    AND n.parent_id     IS NOT NULL
            ) n
            WHERE n.new_order# != n.order#
        ) n
            ON (
                g.app_id        = n.app_id
            AND g.page_id       = n.page_id
        )
        WHEN MATCHED THEN
        UPDATE SET g.order#     = n.new_order#;
        --
        app.log_success();
    END;



    PROCEDURE prep_user_roles_pivot (
        in_page_id              apex_application_pages.page_id%TYPE
    ) AS
        in_collection           CONSTANT apex_collections.collection_name%TYPE := 'P' || TO_CHAR(in_page_id);
        --
        v_query                 VARCHAR2(32767);
        v_cols                  PLS_INTEGER;
        v_cursor                PLS_INTEGER                 := DBMS_SQL.OPEN_CURSOR;
        v_desc                  DBMS_SQL.DESC_TAB;
    BEGIN
        -- build query
        v_query := v_query || 'SELECT' || CHR(10) || '    u.user_id,';
        --
        FOR r IN (
            SELECT r.role_id
            FROM roles r
            WHERE r.app_id = app.get_app_id()
            ORDER BY r.order# NULLS LAST, r.role_group NULLS LAST, r.role_id
        ) LOOP
            v_query := v_query || CHR(10) || '    MAX(CASE WHEN r.role_id = ''' || r.role_id || ''' THEN ''Y'' END) AS ' || LOWER(r.role_id) || '_, ';
        END LOOP;
        --
        v_query := RTRIM(v_query, ', ') || CHR(10) || 'FROM users u LEFT JOIN user_roles r ON r.app_id = app.get_app_id() AND r.user_id = u.user_id' || CHR(10) || 'GROUP BY u.user_id';
        --
        DBMS_OUTPUT.PUT_LINE(v_query);

        -- initialize and populate collection
        IF APEX_COLLECTION.COLLECTION_EXISTS(in_collection) THEN
            APEX_COLLECTION.DELETE_COLLECTION(in_collection);
        END IF;
        --
        APEX_COLLECTION.CREATE_COLLECTION_FROM_QUERY (
            p_collection_name   => in_collection,
            p_query             => v_query
        );

        -- pass proper column names via page items
        DBMS_SQL.PARSE(v_cursor, v_query, DBMS_SQL.NATIVE);
        DBMS_SQL.DESCRIBE_COLUMNS(v_cursor, v_cols, v_desc);
        DBMS_SQL.CLOSE_CURSOR(v_cursor);
        --
        FOR i IN 1 .. v_desc.COUNT LOOP
            BEGIN
                APEX_UTIL.SET_SESSION_STATE (
                    p_name      => 'P' || in_page_id || '_C' || LPAD(i, 3, 0),
                    p_value     => app.get_role_name(RTRIM(v_desc(i).col_name, '_')),
                    p_commit    => FALSE
                );
            EXCEPTION
            WHEN OTHERS THEN
                NULL;           -- item might not exists
            END;
        END LOOP;
    END;



    PROCEDURE save_user_roles (
        in_action       CHAR,
        in_c001         VARCHAR2 := NULL,
        in_c002         VARCHAR2 := NULL,
        in_c003         VARCHAR2 := NULL,
        in_c004         VARCHAR2 := NULL,
        in_c005         VARCHAR2 := NULL,
        in_c006         VARCHAR2 := NULL,
        in_c007         VARCHAR2 := NULL,
        in_c008         VARCHAR2 := NULL,
        in_c009         VARCHAR2 := NULL,
        in_c010         VARCHAR2 := NULL,
        in_c011         VARCHAR2 := NULL,
        in_c012         VARCHAR2 := NULL,
        in_c013         VARCHAR2 := NULL,
        in_c014         VARCHAR2 := NULL,
        in_c015         VARCHAR2 := NULL,
        in_c016         VARCHAR2 := NULL,
        in_c017         VARCHAR2 := NULL,
        in_c018         VARCHAR2 := NULL,
        in_c019         VARCHAR2 := NULL,
        in_c020         VARCHAR2 := NULL,
        in_c021         VARCHAR2 := NULL,
        in_c022         VARCHAR2 := NULL,
        in_c023         VARCHAR2 := NULL,
        in_c024         VARCHAR2 := NULL,
        in_c025         VARCHAR2 := NULL,
        in_c026         VARCHAR2 := NULL,
        in_c027         VARCHAR2 := NULL,
        in_c028         VARCHAR2 := NULL,
        in_c029         VARCHAR2 := NULL,
        in_c030         VARCHAR2 := NULL,
        in_c031         VARCHAR2 := NULL,
        in_c032         VARCHAR2 := NULL,
        in_c033         VARCHAR2 := NULL,
        in_c034         VARCHAR2 := NULL,
        in_c035         VARCHAR2 := NULL,
        in_c036         VARCHAR2 := NULL,
        in_c037         VARCHAR2 := NULL,
        in_c038         VARCHAR2 := NULL,
        in_c039         VARCHAR2 := NULL,
        in_c040         VARCHAR2 := NULL,
        in_c041         VARCHAR2 := NULL,
        in_c042         VARCHAR2 := NULL,
        in_c043         VARCHAR2 := NULL,
        in_c044         VARCHAR2 := NULL,
        in_c045         VARCHAR2 := NULL,
        in_c046         VARCHAR2 := NULL,
        in_c047         VARCHAR2 := NULL,
        in_c048         VARCHAR2 := NULL,
        in_c049         VARCHAR2 := NULL,
        in_c050         VARCHAR2 := NULL
    ) AS
        rec             user_roles%ROWTYPE;
        v_offset        CONSTANT PLS_INTEGER := 1;  -- used columns
    BEGIN
        app.log_module(in_action, in_c001);
        --
        rec.app_id          := app.get_app_id();
        rec.user_id         := in_c001;
        rec.role_id         := NULL;
        rec.updated_by      := app.get_user_id();
        rec.updated_at      := SYSDATE;

        -- cleanup all roles
        DELETE FROM user_roles t
        WHERE t.app_id      = rec.app_id
            AND t.user_id   = rec.user_id;
        --
        IF in_action = 'D' THEN
            app.log_success();
            RETURN;
        END IF;

        -- match order with view on page
        FOR r IN (
            SELECT
                r.role_id,
                'C' || SUBSTR(1000 + v_offset + ROW_NUMBER() OVER(ORDER BY r.role_group NULLS LAST, r.order# NULLS LAST, r.role_id), 2, 3) AS arg
            FROM roles r
            WHERE r.app_id = rec.app_id
        ) LOOP
            rec.role_id := CASE
                WHEN r.arg = 'C002' AND in_c002 = 'Y' THEN r.role_id
                WHEN r.arg = 'C003' AND in_c003 = 'Y' THEN r.role_id
                WHEN r.arg = 'C004' AND in_c004 = 'Y' THEN r.role_id
                WHEN r.arg = 'C005' AND in_c005 = 'Y' THEN r.role_id
                WHEN r.arg = 'C006' AND in_c006 = 'Y' THEN r.role_id
                WHEN r.arg = 'C007' AND in_c007 = 'Y' THEN r.role_id
                WHEN r.arg = 'C008' AND in_c008 = 'Y' THEN r.role_id
                WHEN r.arg = 'C009' AND in_c009 = 'Y' THEN r.role_id
                WHEN r.arg = 'C010' AND in_c010 = 'Y' THEN r.role_id
                WHEN r.arg = 'C011' AND in_c011 = 'Y' THEN r.role_id
                WHEN r.arg = 'C012' AND in_c012 = 'Y' THEN r.role_id
                WHEN r.arg = 'C013' AND in_c013 = 'Y' THEN r.role_id
                WHEN r.arg = 'C014' AND in_c014 = 'Y' THEN r.role_id
                WHEN r.arg = 'C015' AND in_c015 = 'Y' THEN r.role_id
                WHEN r.arg = 'C016' AND in_c016 = 'Y' THEN r.role_id
                WHEN r.arg = 'C017' AND in_c017 = 'Y' THEN r.role_id
                WHEN r.arg = 'C018' AND in_c018 = 'Y' THEN r.role_id
                WHEN r.arg = 'C019' AND in_c019 = 'Y' THEN r.role_id
                WHEN r.arg = 'C020' AND in_c020 = 'Y' THEN r.role_id
                WHEN r.arg = 'C021' AND in_c021 = 'Y' THEN r.role_id
                WHEN r.arg = 'C022' AND in_c022 = 'Y' THEN r.role_id
                WHEN r.arg = 'C023' AND in_c023 = 'Y' THEN r.role_id
                WHEN r.arg = 'C024' AND in_c024 = 'Y' THEN r.role_id
                WHEN r.arg = 'C025' AND in_c025 = 'Y' THEN r.role_id
                WHEN r.arg = 'C026' AND in_c026 = 'Y' THEN r.role_id
                WHEN r.arg = 'C027' AND in_c027 = 'Y' THEN r.role_id
                WHEN r.arg = 'C028' AND in_c028 = 'Y' THEN r.role_id
                WHEN r.arg = 'C029' AND in_c029 = 'Y' THEN r.role_id
                WHEN r.arg = 'C030' AND in_c030 = 'Y' THEN r.role_id
                WHEN r.arg = 'C031' AND in_c031 = 'Y' THEN r.role_id
                WHEN r.arg = 'C032' AND in_c032 = 'Y' THEN r.role_id
                WHEN r.arg = 'C033' AND in_c033 = 'Y' THEN r.role_id
                WHEN r.arg = 'C034' AND in_c034 = 'Y' THEN r.role_id
                WHEN r.arg = 'C035' AND in_c035 = 'Y' THEN r.role_id
                WHEN r.arg = 'C036' AND in_c036 = 'Y' THEN r.role_id
                WHEN r.arg = 'C037' AND in_c037 = 'Y' THEN r.role_id
                WHEN r.arg = 'C038' AND in_c038 = 'Y' THEN r.role_id
                WHEN r.arg = 'C039' AND in_c039 = 'Y' THEN r.role_id
                WHEN r.arg = 'C040' AND in_c040 = 'Y' THEN r.role_id
                WHEN r.arg = 'C041' AND in_c041 = 'Y' THEN r.role_id
                WHEN r.arg = 'C042' AND in_c042 = 'Y' THEN r.role_id
                WHEN r.arg = 'C043' AND in_c043 = 'Y' THEN r.role_id
                WHEN r.arg = 'C044' AND in_c044 = 'Y' THEN r.role_id
                WHEN r.arg = 'C045' AND in_c045 = 'Y' THEN r.role_id
                WHEN r.arg = 'C046' AND in_c046 = 'Y' THEN r.role_id
                WHEN r.arg = 'C047' AND in_c047 = 'Y' THEN r.role_id
                WHEN r.arg = 'C048' AND in_c048 = 'Y' THEN r.role_id
                WHEN r.arg = 'C049' AND in_c049 = 'Y' THEN r.role_id
                WHEN r.arg = 'C050' AND in_c050 = 'Y' THEN r.role_id
                END;
            --
            IF rec.role_id IS NOT NULL THEN
                INSERT INTO user_roles
                VALUES rec;
            END IF;
        END LOOP;
        --
        app.log_success();
    EXCEPTION
    WHEN app.app_exception THEN
        RAISE;
    WHEN OTHERS THEN
        app.raise_error();
    END;



    PROCEDURE save_setting (
        in_action               CHAR,
        in_setting_name_old     settings.setting_name%TYPE,
        in_setting_name         settings.setting_name%TYPE,
        in_setting_group        settings.setting_group%TYPE         := NULL,
        in_setting_value        settings.setting_value%TYPE         := NULL,
        in_is_numeric           settings.is_numeric%TYPE            := NULL,
        in_is_date              settings.is_date%TYPE               := NULL,
        in_is_private           settings.is_private%TYPE            := NULL,
        in_description          settings.description_%TYPE          := NULL
    )
    AS
        rec                     settings%ROWTYPE;
    BEGIN
        app.log_module_json (
            'action',           in_action,
            'name_old',         in_setting_name_old,
            'name',             in_setting_name,
            'value',            in_setting_value,
            'group',            in_setting_group,
            'is_numeric',       in_is_numeric,
            'is_date',          in_is_date,
            'is_private',       in_is_private
        );
        --
        rec.app_id              := app.get_app_id();
        rec.setting_name        := UPPER(in_setting_name);
        rec.setting_value       := in_setting_value;
        rec.setting_context     := NULL;
        rec.setting_group       := in_setting_group;
        rec.is_numeric          := in_is_numeric;
        rec.is_date             := in_is_date;
        rec.is_private          := in_is_private;
        rec.description_        := in_description;
        rec.updated_by          := app.get_user_id();
        rec.updated_at          := SYSDATE;
        --
        CASE in_action
        WHEN 'D' THEN
            DELETE FROM settings s
            WHERE s.app_id              = rec.app_id
                AND s.setting_name      = in_setting_name_old;
        --
        WHEN 'U' THEN
            UPDATE settings s
            SET ROW                     = rec
            WHERE s.app_id              = rec.app_id
                AND s.setting_name      = in_setting_name_old
                AND s.setting_context   IS NULL;
            --
            IF SQL%ROWCOUNT = 0 THEN
                app.raise_error('SETTINGS_UPDATE_FAILED');
            END IF;
            --
            UPDATE settings s
            SET s.setting_name          = rec.setting_name
            WHERE s.app_id              = rec.app_id
                AND s.setting_name      = in_setting_name_old;
        --
        ELSE
            BEGIN
                INSERT INTO settings VALUES rec;
            EXCEPTION
            WHEN DUP_VAL_ON_INDEX THEN
                app.raise_error('SETTINGS_EXISTS');
            END;
        END CASE;
    EXCEPTION
    WHEN app.app_exception THEN
        RAISE;
    WHEN OTHERS THEN
        app.raise_error();
    END;



    PROCEDURE set_setting_bulk (
        in_c001         settings.setting_value%TYPE,
        in_c002         settings.setting_value%TYPE,
        in_c003         settings.setting_value%TYPE         := NULL,
        in_c004         settings.setting_value%TYPE         := NULL,
        in_c005         settings.setting_value%TYPE         := NULL,
        in_c006         settings.setting_value%TYPE         := NULL,
        in_c007         settings.setting_value%TYPE         := NULL,
        in_c008         settings.setting_value%TYPE         := NULL,
        in_c009         settings.setting_value%TYPE         := NULL,
        in_c010         settings.setting_value%TYPE         := NULL,
        in_c011         settings.setting_value%TYPE         := NULL,
        in_c012         settings.setting_value%TYPE         := NULL,
        in_c013         settings.setting_value%TYPE         := NULL,
        in_c014         settings.setting_value%TYPE         := NULL,
        in_c015         settings.setting_value%TYPE         := NULL,
        in_c016         settings.setting_value%TYPE         := NULL,
        in_c017         settings.setting_value%TYPE         := NULL,
        in_c018         settings.setting_value%TYPE         := NULL,
        in_c019         settings.setting_value%TYPE         := NULL,
        in_c020         settings.setting_value%TYPE         := NULL,
        in_c021         settings.setting_value%TYPE         := NULL,
        in_c022         settings.setting_value%TYPE         := NULL,
        in_c023         settings.setting_value%TYPE         := NULL,
        in_c024         settings.setting_value%TYPE         := NULL,
        in_c025         settings.setting_value%TYPE         := NULL,
        in_c026         settings.setting_value%TYPE         := NULL,
        in_c027         settings.setting_value%TYPE         := NULL,
        in_c028         settings.setting_value%TYPE         := NULL,
        in_c029         settings.setting_value%TYPE         := NULL,
        in_c030         settings.setting_value%TYPE         := NULL,
        in_c031         settings.setting_value%TYPE         := NULL,
        in_c032         settings.setting_value%TYPE         := NULL,
        in_c033         settings.setting_value%TYPE         := NULL,
        in_c034         settings.setting_value%TYPE         := NULL,
        in_c035         settings.setting_value%TYPE         := NULL,
        in_c036         settings.setting_value%TYPE         := NULL,
        in_c037         settings.setting_value%TYPE         := NULL,
        in_c038         settings.setting_value%TYPE         := NULL,
        in_c039         settings.setting_value%TYPE         := NULL,
        in_c040         settings.setting_value%TYPE         := NULL,
        in_c041         settings.setting_value%TYPE         := NULL,
        in_c042         settings.setting_value%TYPE         := NULL,
        in_c043         settings.setting_value%TYPE         := NULL,
        in_c044         settings.setting_value%TYPE         := NULL,
        in_c045         settings.setting_value%TYPE         := NULL,
        in_c046         settings.setting_value%TYPE         := NULL,
        in_c047         settings.setting_value%TYPE         := NULL,
        in_c048         settings.setting_value%TYPE         := NULL,
        in_c049         settings.setting_value%TYPE         := NULL,
        in_c050         settings.setting_value%TYPE         := NULL
    )
    AS
        rec             settings%ROWTYPE;
        v_offset        CONSTANT PLS_INTEGER := 3;  -- used columns (name, group, default)
    BEGIN
        app.log_module(in_c001, in_c002, in_c003, in_c004, in_c005, in_c006, in_c007, in_c008);
        --
        rec.app_id              := app.get_app_id();
        rec.setting_name        := in_c001;
        rec.setting_value       := in_c003;                 -- fill in the loop
        rec.setting_context     := NULL;                    -- fill in the loop
        rec.setting_group       := in_c002;
        rec.updated_by          := app.get_user_id();
        rec.updated_at          := SYSDATE;
    
        -- cleanup setting
        DELETE FROM settings s
        WHERE s.app_id              = rec.app_id
            AND s.setting_name      = rec.setting_name
            AND s.setting_context   IS NOT NULL;

        -- update default value
        UPDATE settings s
        SET ROW                     = rec
        WHERE s.app_id              = rec.app_id
            AND s.setting_name      = rec.setting_name
            AND s.setting_context   IS NULL;

        -- match order with view on page
        FOR r IN (
            SELECT
                s.context_id,
                'C' || SUBSTR(1000 + v_offset + ROW_NUMBER() OVER(ORDER BY s.order# NULLS LAST, s.context_id), 2, 3) AS arg
            FROM setting_contexts s
            WHERE s.app_id = rec.app_id
        ) LOOP
            CONTINUE WHEN r.arg IN ('C001', 'C002', 'C003');
            --
            rec.setting_context := CASE
                WHEN r.arg = 'C003' THEN r.context_id       WHEN r.arg = 'C004' THEN r.context_id
                WHEN r.arg = 'C005' THEN r.context_id       WHEN r.arg = 'C006' THEN r.context_id
                WHEN r.arg = 'C007' THEN r.context_id       WHEN r.arg = 'C008' THEN r.context_id
                WHEN r.arg = 'C009' THEN r.context_id       WHEN r.arg = 'C010' THEN r.context_id
                WHEN r.arg = 'C011' THEN r.context_id       WHEN r.arg = 'C012' THEN r.context_id
                WHEN r.arg = 'C013' THEN r.context_id       WHEN r.arg = 'C014' THEN r.context_id
                WHEN r.arg = 'C015' THEN r.context_id       WHEN r.arg = 'C016' THEN r.context_id
                WHEN r.arg = 'C017' THEN r.context_id       WHEN r.arg = 'C018' THEN r.context_id
                WHEN r.arg = 'C019' THEN r.context_id       WHEN r.arg = 'C020' THEN r.context_id
                WHEN r.arg = 'C021' THEN r.context_id       WHEN r.arg = 'C022' THEN r.context_id
                WHEN r.arg = 'C023' THEN r.context_id       WHEN r.arg = 'C024' THEN r.context_id
                WHEN r.arg = 'C025' THEN r.context_id       WHEN r.arg = 'C026' THEN r.context_id
                WHEN r.arg = 'C027' THEN r.context_id       WHEN r.arg = 'C028' THEN r.context_id
                WHEN r.arg = 'C029' THEN r.context_id       WHEN r.arg = 'C030' THEN r.context_id
                WHEN r.arg = 'C031' THEN r.context_id       WHEN r.arg = 'C032' THEN r.context_id
                WHEN r.arg = 'C033' THEN r.context_id       WHEN r.arg = 'C034' THEN r.context_id
                WHEN r.arg = 'C035' THEN r.context_id       WHEN r.arg = 'C036' THEN r.context_id
                WHEN r.arg = 'C037' THEN r.context_id       WHEN r.arg = 'C038' THEN r.context_id
                WHEN r.arg = 'C039' THEN r.context_id       WHEN r.arg = 'C040' THEN r.context_id
                WHEN r.arg = 'C041' THEN r.context_id       WHEN r.arg = 'C042' THEN r.context_id
                WHEN r.arg = 'C043' THEN r.context_id       WHEN r.arg = 'C044' THEN r.context_id
                WHEN r.arg = 'C045' THEN r.context_id       WHEN r.arg = 'C046' THEN r.context_id
                WHEN r.arg = 'C047' THEN r.context_id       WHEN r.arg = 'C048' THEN r.context_id
                WHEN r.arg = 'C049' THEN r.context_id       WHEN r.arg = 'C050' THEN r.context_id
                END;
            --
            rec.setting_value := CASE
                WHEN r.arg = 'C003' THEN in_c003            WHEN r.arg = 'C004' THEN in_c004
                WHEN r.arg = 'C005' THEN in_c005            WHEN r.arg = 'C006' THEN in_c006
                WHEN r.arg = 'C007' THEN in_c007            WHEN r.arg = 'C008' THEN in_c008
                WHEN r.arg = 'C009' THEN in_c009            WHEN r.arg = 'C010' THEN in_c010
                WHEN r.arg = 'C011' THEN in_c011            WHEN r.arg = 'C012' THEN in_c012
                WHEN r.arg = 'C013' THEN in_c013            WHEN r.arg = 'C014' THEN in_c014
                WHEN r.arg = 'C015' THEN in_c015            WHEN r.arg = 'C016' THEN in_c016
                WHEN r.arg = 'C017' THEN in_c017            WHEN r.arg = 'C018' THEN in_c018
                WHEN r.arg = 'C019' THEN in_c019            WHEN r.arg = 'C020' THEN in_c020
                WHEN r.arg = 'C021' THEN in_c021            WHEN r.arg = 'C022' THEN in_c022
                WHEN r.arg = 'C023' THEN in_c023            WHEN r.arg = 'C024' THEN in_c024
                WHEN r.arg = 'C025' THEN in_c025            WHEN r.arg = 'C026' THEN in_c026
                WHEN r.arg = 'C027' THEN in_c027            WHEN r.arg = 'C028' THEN in_c028
                WHEN r.arg = 'C029' THEN in_c029            WHEN r.arg = 'C030' THEN in_c030
                WHEN r.arg = 'C031' THEN in_c031            WHEN r.arg = 'C032' THEN in_c032
                WHEN r.arg = 'C033' THEN in_c033            WHEN r.arg = 'C034' THEN in_c034
                WHEN r.arg = 'C035' THEN in_c035            WHEN r.arg = 'C036' THEN in_c036
                WHEN r.arg = 'C037' THEN in_c037            WHEN r.arg = 'C038' THEN in_c038
                WHEN r.arg = 'C039' THEN in_c039            WHEN r.arg = 'C040' THEN in_c040
                WHEN r.arg = 'C041' THEN in_c041            WHEN r.arg = 'C042' THEN in_c042
                WHEN r.arg = 'C043' THEN in_c043            WHEN r.arg = 'C044' THEN in_c044
                WHEN r.arg = 'C045' THEN in_c045            WHEN r.arg = 'C046' THEN in_c046
                WHEN r.arg = 'C047' THEN in_c047            WHEN r.arg = 'C048' THEN in_c048
                WHEN r.arg = 'C049' THEN in_c049            WHEN r.arg = 'C050' THEN in_c050
                END;
            --
            CONTINUE WHEN (rec.setting_context IS NULL OR rec.setting_value IS NULL);
            --
            INSERT INTO settings
            VALUES rec;
        END LOOP;
        --
        app.log_success();
    EXCEPTION
    WHEN app.app_exception THEN
        RAISE;
    WHEN OTHERS THEN
        app.raise_error();
    END;



    PROCEDURE prep_settings_pivot (
        in_page_id              apex_application_pages.page_id%TYPE
    ) AS
        in_collection           CONSTANT apex_collections.collection_name%TYPE := 'P' || TO_CHAR(in_page_id);
        --
        v_query                 VARCHAR2(32767);
        v_cols                  PLS_INTEGER;
        v_cursor                PLS_INTEGER                 := DBMS_SQL.OPEN_CURSOR;
        v_desc                  DBMS_SQL.DESC_TAB;
        --
        v_context_name          setting_contexts.context_name%TYPE;
    BEGIN
        -- build query
        v_query := v_query || 'SELECT' || CHR(10);
        v_query := v_query || '    s.setting_name,' || CHR(10);
        v_query := v_query || '    MAX(s.setting_group) AS setting_group,' || CHR(10);
        v_query := v_query || '    MAX(CASE WHEN s.setting_context IS NULL THEN s.setting_value END) AS null__,' || CHR(10);
        --
        FOR c IN (
            SELECT c.context_id
            FROM setting_contexts c
            WHERE c.app_id = app.get_app_id()
            ORDER BY c.order#, c.context_id
        ) LOOP
            v_query := v_query || '    MAX(CASE WHEN s.setting_context = ''' || c.context_id || ''' THEN s.setting_value END) AS ' || LOWER(c.context_id) || '_,' || CHR(10);
        END LOOP;
        --
        v_query := RTRIM(RTRIM(v_query, CHR(10)), ',') || CHR(10);
        v_query := v_query || 'FROM settings s' || CHR(10);
        v_query := v_query || 'WHERE s.app_id = app.get_app_id()' || CHR(10);
        v_query := v_query || 'GROUP BY s.setting_name';
        --
        app.log_debug(in_payload => v_query);
        DBMS_OUTPUT.PUT_LINE(v_query);

        -- initialize and populate collection
        IF APEX_COLLECTION.COLLECTION_EXISTS(in_collection) THEN
            APEX_COLLECTION.DELETE_COLLECTION(in_collection);
        END IF;
        --
        APEX_COLLECTION.CREATE_COLLECTION_FROM_QUERY (
            p_collection_name   => in_collection,
            p_query             => v_query
        );

        -- pass proper column names via page items
        DBMS_SQL.PARSE(v_cursor, v_query, DBMS_SQL.NATIVE);
        DBMS_SQL.DESCRIBE_COLUMNS(v_cursor, v_cols, v_desc);
        DBMS_SQL.CLOSE_CURSOR(v_cursor);
        --
        FOR i IN 1 .. v_desc.COUNT LOOP
            BEGIN
                SELECT NVL(c.context_name, c.context_id) INTO v_context_name
                FROM setting_contexts c
                WHERE c.app_id          = app.get_app_id()
                    AND c.context_id    = RTRIM(v_desc(i).col_name, '_');
                --
                APEX_UTIL.SET_SESSION_STATE (
                    p_name      => 'P' || in_page_id || '_C' || LPAD(i, 3, 0),
                    p_value     => v_context_name,
                    p_commit    => FALSE
                );
            EXCEPTION
            WHEN OTHERS THEN
                NULL;           -- item might not exists
            END;
        END LOOP;
    EXCEPTION
    WHEN app.app_exception THEN
        RAISE;
    WHEN OTHERS THEN
        app.raise_error();
    END;



    PROCEDURE save_obj_tables (
        in_action               CHAR,
        in_table_name           obj_tables.table_name%TYPE,
        in_table_group          obj_tables.table_group%TYPE        := NULL,
        in_is_dml_handler       obj_tables.is_dml_handler%TYPE     := NULL,
        in_is_row_mov           obj_tables.is_row_mov%TYPE         := NULL,
        in_is_read_only         obj_tables.is_read_only%TYPE       := NULL,
        in_comments             obj_tables.comments%TYPE           := NULL
    ) AS
    BEGIN
        app.log_module(in_table_name, in_table_group, in_is_dml_handler, in_is_row_mov, in_is_read_only, in_comments);
        --
        FOR c IN (
            SELECT t.*
            FROM obj_tables t
            WHERE t.table_name = in_table_name
        ) LOOP
            -- lock/unlock table
            IF NVL(c.is_read_only, '-') != NVL(in_is_read_only, '-') THEN
                EXECUTE IMMEDIATE
                    'ALTER TABLE ' || in_table_name ||
                    ' READ ' || CASE WHEN in_is_read_only = 'Y' THEN 'ONLY' ELSE 'WRITE' END;
            END IF;

            -- row movement change
            IF NVL(c.is_row_mov, '-') != NVL(in_is_row_mov, '-') THEN
                EXECUTE IMMEDIATE
                    'ALTER TABLE ' || in_table_name ||
                    CASE WHEN in_is_row_mov = 'Y' THEN 'ENABLE' ELSE 'DISABLE' END || ' ROW MOVEMENT';
            END IF;

            -- table comment
            EXECUTE IMMEDIATE
                'COMMENT ON TABLE ' || in_table_name ||
                ' IS ''' || CASE WHEN in_comments NOT LIKE '[%]%' THEN REPLACE('[' || in_table_group || '] ', '[] ', '') END || in_comments || '''';

            -- create/drop DML table
            IF NVL(c.is_dml_handler, '-') != NVL(in_is_dml_handler, '-') THEN
                IF in_is_dml_handler = 'Y' THEN
                    app.create_dml_table(in_table_name);
                ELSIF in_is_dml_handler IS NULL THEN
                    app.drop_dml_table(in_table_name);
                END IF;
            END IF;
        END LOOP;
        --
        app.log_success();
    EXCEPTION
    WHEN app.app_exception THEN
        RAISE;
    WHEN OTHERS THEN
        app.raise_error();
    END;



    PROCEDURE save_obj_columns (
        in_action               CHAR,
        in_table_name           obj_columns.table_name%TYPE,
        in_column_id            obj_columns.column_id%TYPE          := NULL,
        in_column_name          obj_columns.column_name%TYPE        := NULL,
        in_column_name_old      obj_columns.column_name_old%TYPE    := NULL,
        in_is_nn                obj_columns.is_nn%TYPE              := NULL,
        in_data_type            obj_columns.data_type%TYPE          := NULL,
        in_data_default         obj_columns.data_default%TYPE       := NULL,
        in_comments             obj_columns.comments%TYPE           := NULL
    ) AS
        rec                     obj_columns%ROWTYPE;
    BEGIN
        app.log_module_json (
            'table_name',       in_table_name,
            'column_name',      in_column_name,
            'column_id',        in_column_id,
            'nn',               in_is_nn
        );

        -- remove column
        IF in_action = 'D' THEN
            app.log_result('REMOVING COLUMN');
            EXECUTE IMMEDIATE
                'ALTER TABLE ' || in_table_name ||
                ' DROP COLUMN ' || in_column_name_old;
            --
            RETURN;
        END IF;

        -- add column
        IF in_action = 'C' THEN
            app.log_result('ADDING COLUMN');
            EXECUTE IMMEDIATE
                'ALTER TABLE ' || in_table_name ||
                ' ADD ' || in_column_name || ' ' || in_data_type ||
                CASE WHEN in_data_default IS NOT NULL THEN ' DEFAULT ' || in_data_default END ||
                CASE WHEN in_is_nn = 'Y' THEN ' NOT NULL' END;
            --
            EXECUTE IMMEDIATE
                'COMMENT ON COLUMN ' || in_table_name || '.' || in_column_name ||
                ' IS ''' || in_comments || '''';
            --
            RETURN;
        END IF;

        -- check changes
        FOR c IN (
            SELECT
                c.column_id,
                c.data_type,
                c.data_default,
                c.is_nn,
                c.comments
            FROM obj_columns c
            WHERE c.table_name      = in_table_name
                AND c.column_name   = in_column_name_old
        ) LOOP
            -- remove NOT NULL constraint
            IF c.is_nn = 'Y' AND in_is_nn IS NULL THEN
                app.log_result('REMOVING NOT NULL');
                EXECUTE IMMEDIATE
                    'ALTER TABLE ' || in_table_name ||
                    ' MODIFY ' || in_column_name_old || ' NULL';
            END IF;

            -- change data type (if possible)
            IF c.data_type != in_data_type THEN
                app.log_result('UPDATING DATA TYPE');
                EXECUTE IMMEDIATE
                    'ALTER TABLE ' || in_table_name ||
                    ' MODIFY ' || in_column_name_old || ' ' || in_data_type ||
                    CASE
                        WHEN in_data_default IS NOT NULL THEN ' DEFAULT ' || in_data_default
                        WHEN c.data_default  IS NOT NULL THEN ' DEFAULT NULL'
                        END;
            ELSIF NVL(c.data_default, '^!^') != NVL(in_data_default, '^!^') THEN
                app.log_result('UPDATING DATA DEFAULT');
                EXECUTE IMMEDIATE
                    'ALTER TABLE ' || in_table_name ||
                    ' MODIFY ' || in_column_name_old || ' DEFAULT ' || NVL(in_data_default, 'NULL');
            END IF;

            -- add NOT NULL constraint
            IF c.is_nn IS NULL AND in_is_nn = 'Y' THEN
                app.log_result('ADDING NOT NULL');
                EXECUTE IMMEDIATE
                    'ALTER TABLE ' || in_table_name ||
                    ' MODIFY ' || in_column_name_old || ' NOT NULL';
            END IF;
            
            -- update column comments
            IF NVL(c.comments, '^!^') != NVL(in_comments, '^!^') THEN
                app.log_result('UPDATING COMMENTS');
                EXECUTE IMMEDIATE
                    'COMMENT ON COLUMN ' || in_table_name || '.' || in_column_name_old ||
                    ' IS ''' || in_comments || '''';
            END IF;
        END LOOP;

        -- rename column
        IF in_column_name != in_column_name_old THEN
            app.log_result('RENAMING COLUMN');
            EXECUTE IMMEDIATE
                'ALTER TABLE ' || in_table_name ||
                ' RENAME COLUMN ' || in_column_name_old ||
                ' TO ' || in_column_name;
        END IF;
        --
        app.log_success();
    EXCEPTION
    WHEN app.app_exception THEN
        RAISE;
    WHEN OTHERS THEN
        app.raise_error();
    END;



    PROCEDURE move_table_columns_bottom (
        in_table_name       VARCHAR2,
        in_columns          VARCHAR2
    )
    AS
    BEGIN
        app.log_module(in_table_name, in_columns);
        --
        FOR c IN (
            SELECT t.column_value AS column_name
            FROM TABLE(APEX_STRING.SPLIT(RTRIM(in_columns, ':'), ':')) t
        ) LOOP
            EXECUTE IMMEDIATE
                'ALTER TABLE ' || in_table_name || ' MODIFY ' || c.column_name || ' INVISIBLE';
            --
            EXECUTE IMMEDIATE
                'ALTER TABLE ' || in_table_name || ' MODIFY ' || c.column_name || ' VISIBLE';
        END LOOP;
        --
        app.log_success();
    END;



    PROCEDURE save_translations_overview (
        in_action           CHAR,
        in_app_id           translations_overview.app_id%TYPE,
        in_page_id_old      translations_overview.page_id_old%TYPE,
        in_page_id          translations_overview.page_id%TYPE,
        in_name_old         translations_overview.name_old%TYPE,
        in_name             translations_overview.name%TYPE,
        in_value_en         translations_overview.value_en%TYPE       := NULL,
        in_value_cz         translations_overview.value_cz%TYPE       := NULL,
        in_value_sk         translations_overview.value_sk%TYPE       := NULL,
        in_value_pl         translations_overview.value_pl%TYPE       := NULL,
        in_value_hu         translations_overview.value_hu%TYPE       := NULL
    ) AS
        rec                 translations%ROWTYPE;
    BEGIN
        app.log_module(in_action, in_page_id_old, in_page_id, in_name_old, in_name);
        --
        rec.app_id          := in_app_id;
        rec.page_id         := NVL(in_page_id, 0);
        rec.name            := in_name;
        rec.value_en        := in_value_en;
        rec.value_cz        := in_value_cz;
        rec.value_sk        := in_value_sk;
        rec.value_pl        := in_value_pl;
        rec.value_hu        := in_value_hu;
        --
        IF in_action = 'D' THEN
            DELETE FROM translations t
            WHERE t.app_id      = in_app_id
                AND t.page_id   = in_page_id_old
                AND t.name      = in_name_old;
            --
            app.log_success();
            RETURN;
        END IF;
        --
        UPDATE translations t
        SET ROW             = rec
        WHERE t.app_id      = in_app_id
            AND t.page_id   = in_page_id_old
            AND t.name      = in_name_old;
        --
        IF SQL%ROWCOUNT = 0 THEN
            INSERT INTO translations
            VALUES rec;
        END IF;
        --
        app.log_success();
    EXCEPTION
    WHEN app.app_exception THEN
        RAISE;
    WHEN OTHERS THEN
        app.raise_error();
    END;

END;
/
