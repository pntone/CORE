CREATE OR REPLACE PACKAGE BODY app_actions AS

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
        --
        app.log_success();
    END;



    FUNCTION get_role_name (
        in_role_id              roles.role_id%TYPE
    )
    RETURN roles.role_name%TYPE
    AS
        out_name                roles.role_name%TYPE;
    BEGIN
        SELECT NVL(r.role_name, r.role_id) INTO out_name
        FROM roles r
        WHERE r.app_id          = app.get_app_id()
            AND r.role_id       = in_role_id;
        --
        RETURN out_name;
    EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN in_role_id;
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
            ORDER BY r.role_group NULLS LAST, r.order# NULLS LAST, r.role_id
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
                    p_value     => get_role_name(RTRIM(v_desc(i).col_name, '_')),
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
        rec user_roles%ROWTYPE;
    BEGIN
        app.log_module(app.get_json_list(in_action, in_c001));
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
                'C' || SUBSTR(1001 + ROW_NUMBER() OVER(ORDER BY r.role_group NULLS LAST, r.order# NULLS LAST, r.role_id), 2, 3) AS arg
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

END;
/