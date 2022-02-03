prompt --application/pages/page_00000
begin
--   Manifest
--     PAGE: 00000
--   Manifest End
wwv_flow_api.component_begin (
 p_version_yyyy_mm_dd=>'2021.04.15'
,p_release=>'21.1.7'
,p_default_workspace_id=>9014660246496943
,p_default_application_id=>770
,p_default_id_offset=>0
,p_default_owner=>'CORE'
);
wwv_flow_api.create_page(
 p_id=>0
,p_user_interface_id=>wwv_flow_api.id(9169746885570061)
,p_name=>'Global Page'
,p_step_title=>'Global Page'
,p_autocomplete_on_off=>'OFF'
,p_page_template_options=>'#DEFAULT#'
,p_protection_level=>'D'
,p_last_updated_by=>'DEV'
,p_last_upd_yyyymmddhh24miss=>'20220123122358'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(16222516003514114)
,p_plug_name=>'DEV'
,p_region_template_options=>'#DEFAULT#'
,p_region_attributes=>'style="margin-bottom: 5rem;"'
,p_plug_template=>wwv_flow_api.id(9049155795569902)
,p_plug_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'REGION_POSITION_05'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_required_role=>wwv_flow_api.id(9556407311505078)
,p_plug_display_condition_type=>'EXPRESSION'
,p_plug_display_when_condition=>'app.is_debug_on()'
,p_plug_display_when_cond2=>'PLSQL'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_report_region(
 p_id=>wwv_flow_api.id(16221637563514105)
,p_name=>'Page Items [DATA]'
,p_parent_plug_id=>wwv_flow_api.id(16222516003514114)
,p_template=>wwv_flow_api.id(9078290074569925)
,p_display_sequence=>50
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#:t-AVPList--fixedLabelLarge:t-AVPList--leftAligned:t-Report--hideNoPagination'
,p_grid_column_span=>4
,p_display_point=>'BODY'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT',
'    CASE',
'        WHEN (REGEXP_LIKE(app.get_request_url(), ''[:,]'' || i.item_name || ''[,:]'')',
'            OR REGEXP_LIKE(app.get_request_url(), ''[\?&'' || '']'' || LOWER(i.item_name) || ''[=&'' || '']'')',
'        )',
'        THEN ''<b>'' || i.item_name || ''</b>''',
'        ELSE i.item_name',
'        END AS item_name,',
'    app.get_item(i.item_name)       AS item_value',
'FROM apex_application_page_items i',
'WHERE i.application_id              = app.get_app_id()',
'    AND i.page_id                   = app.get_page_id()',
'ORDER BY i.item_name;',
''))
,p_ajax_enabled=>'Y'
,p_lazy_loading=>false
,p_query_row_template=>wwv_flow_api.id(9115257435569961)
,p_query_num_rows=>100
,p_query_options=>'DERIVED_REPORT_COLUMNS'
,p_csv_output=>'N'
,p_prn_output=>'N'
,p_sort_null=>'L'
,p_plug_query_strip_html=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(16221782509514106)
,p_query_column_id=>1
,p_column_alias=>'ITEM_NAME'
,p_column_display_sequence=>10
,p_column_heading=>'Item Name'
,p_use_as_row_header=>'N'
,p_display_as=>'WITHOUT_MODIFICATION'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(16221810155514107)
,p_query_column_id=>2
,p_column_alias=>'ITEM_VALUE'
,p_column_display_sequence=>20
,p_column_heading=>'Item Value'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_region(
 p_id=>wwv_flow_api.id(16222122706514110)
,p_name=>'App/Global Items [DATA]'
,p_parent_plug_id=>wwv_flow_api.id(16222516003514114)
,p_template=>wwv_flow_api.id(9078290074569925)
,p_display_sequence=>60
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#:t-AVPList--fixedLabelMedium:t-AVPList--leftAligned:t-Report--hideNoPagination'
,p_new_grid_row=>false
,p_grid_column_span=>4
,p_display_point=>'BODY'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT',
'    CASE',
'        WHEN (REGEXP_LIKE(app.get_request_url(), ''[:,]'' || i.item_name || ''[,:]'')',
'            OR REGEXP_LIKE(app.get_request_url(), ''[\?&'' || '']'' || LOWER(i.item_name) || ''[=&'' || '']'')',
'        )',
'        THEN ''<b>'' || i.item_name || ''</b>''',
'        ELSE i.item_name',
'        END AS item_name,',
'    i.item_value',
'FROM (',
'    SELECT',
'        i.item_name,',
'        app.get_item(i.item_name) AS item_value',
'    FROM apex_application_items i',
'    WHERE i.application_id  = app.get_app_id()',
'    UNION ALL',
'    SELECT',
'        i.item_name,',
'        app.get_item(i.item_name) AS item_value',
'    FROM apex_application_page_items i',
'    WHERE i.application_id  = app.get_app_id()',
'        AND i.page_id       = 0',
') i',
'ORDER BY i.item_name;',
''))
,p_ajax_enabled=>'Y'
,p_lazy_loading=>false
,p_query_row_template=>wwv_flow_api.id(9115257435569961)
,p_query_num_rows=>100
,p_query_options=>'DERIVED_REPORT_COLUMNS'
,p_csv_output=>'N'
,p_prn_output=>'N'
,p_sort_null=>'L'
,p_plug_query_strip_html=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(16222241084514111)
,p_query_column_id=>1
,p_column_alias=>'ITEM_NAME'
,p_column_display_sequence=>10
,p_column_heading=>'Item Name'
,p_use_as_row_header=>'N'
,p_display_as=>'WITHOUT_MODIFICATION'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(16222360232514112)
,p_query_column_id=>2
,p_column_alias=>'ITEM_VALUE'
,p_column_display_sequence=>20
,p_column_heading=>'Item Value'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(16222425620514113)
,p_plug_name=>'Debug for Developers'
,p_parent_plug_id=>wwv_flow_api.id(16222516003514114)
,p_icon_css_classes=>'fa-bug'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(9070356145569920)
,p_plug_display_sequence=>10
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(16470181577696749)
,p_plug_name=>'Page Items'
,p_parent_plug_id=>wwv_flow_api.id(16222516003514114)
,p_region_template_options=>'#DEFAULT#:t-HeroRegion--hideIcon'
,p_region_attributes=>'style="margin-top: -1rem;"'
,p_plug_template=>wwv_flow_api.id(9070356145569920)
,p_plug_display_sequence=>20
,p_plug_grid_column_span=>4
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(16470239693696750)
,p_plug_name=>'App/Global Items'
,p_parent_plug_id=>wwv_flow_api.id(16222516003514114)
,p_region_template_options=>'#DEFAULT#:t-HeroRegion--hideIcon'
,p_region_attributes=>'style="margin-top: -1rem;"'
,p_plug_template=>wwv_flow_api.id(9070356145569920)
,p_plug_display_sequence=>30
,p_plug_new_grid_row=>false
,p_plug_grid_column_span=>4
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(17062142630582707)
,p_plug_name=>'SYS_CONTEXT'
,p_parent_plug_id=>wwv_flow_api.id(16222516003514114)
,p_region_template_options=>'#DEFAULT#:t-HeroRegion--hideIcon'
,p_region_attributes=>'style="margin-top: -1rem;"'
,p_plug_template=>wwv_flow_api.id(9070356145569920)
,p_plug_display_sequence=>40
,p_plug_new_grid_row=>false
,p_plug_grid_column_span=>4
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_report_region(
 p_id=>wwv_flow_api.id(17062213215582708)
,p_name=>'SYS_CONTEXT [DATA]'
,p_parent_plug_id=>wwv_flow_api.id(16222516003514114)
,p_template=>wwv_flow_api.id(9078290074569925)
,p_display_sequence=>70
,p_region_css_classes=>'style="overflow-x: hidden;"'
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#:t-AVPList--fixedLabelLarge:t-AVPList--leftAligned:t-Report--hideNoPagination'
,p_new_grid_row=>false
,p_grid_column_span=>4
,p_display_point=>'BODY'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT',
'    x.namespace || ''.'' || x.attribute AS name,',
'    x.value',
'FROM session_context x',
'ORDER BY 1;',
''))
,p_ajax_enabled=>'Y'
,p_lazy_loading=>false
,p_query_row_template=>wwv_flow_api.id(9115257435569961)
,p_query_num_rows=>100
,p_query_options=>'DERIVED_REPORT_COLUMNS'
,p_csv_output=>'N'
,p_prn_output=>'N'
,p_sort_null=>'L'
,p_plug_query_strip_html=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(17062566806582711)
,p_query_column_id=>1
,p_column_alias=>'NAME'
,p_column_display_sequence=>10
,p_column_heading=>'Name'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(17062636115582712)
,p_query_column_id=>2
,p_column_alias=>'VALUE'
,p_column_display_sequence=>20
,p_column_heading=>'Value'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(17062776241582713)
,p_plug_name=>'CGI'
,p_parent_plug_id=>wwv_flow_api.id(16222516003514114)
,p_region_template_options=>'#DEFAULT#:t-HeroRegion--hideIcon'
,p_region_attributes=>'style="margin-top: -1rem;"'
,p_plug_template=>wwv_flow_api.id(9070356145569920)
,p_plug_display_sequence=>100
,p_plug_new_grid_row=>false
,p_plug_grid_column_span=>4
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_report_region(
 p_id=>wwv_flow_api.id(17062881718582714)
,p_name=>'CGI [DATA]'
,p_parent_plug_id=>wwv_flow_api.id(16222516003514114)
,p_template=>wwv_flow_api.id(9078290074569925)
,p_display_sequence=>130
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#:t-AVPList--fixedLabelMedium:t-AVPList--leftAligned:t-Report--hideNoPagination'
,p_region_attributes=>'style="overflow-x: hidden;"'
,p_new_grid_row=>false
,p_grid_column_span=>4
,p_display_point=>'BODY'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'WITH t AS (',
'    SELECT',
'        ''QUERY_STRING,AUTHORIZATION,DAD_NAME,DOC_ACCESS_PATH,DOCUMENT_TABLE,'' ||',
'        ''HTTP_ACCEPT,HTTP_ACCEPT_ENCODING,HTTP_ACCEPT_CHARSET,HTTP_ACCEPT_LANGUAGE,'' ||',
'        ''HTTP_COOKIE,HTTP_HOST,HTTP_PRAGMA,HTTP_REFERER,HTTP_USER_AGENT,'' ||',
'        ''PATH_ALIAS,PATH_INFO,REMOTE_ADDR,REMOTE_HOST,REMOTE_USER,'' ||',
'        ''REQUEST_CHARSET,REQUEST_IANA_CHARSET,REQUEST_METHOD,REQUEST_PROTOCOL,'' ||',
'        ''SCRIPT_NAME,SCRIPT_PREFIX,SERVER_NAME,SERVER_PORT,SERVER_PROTOCOL'' AS str',
'    FROM DUAL',
')',
'SELECT',
'    REGEXP_SUBSTR(str, ''[^,]+'', 1, LEVEL) AS name,',
'    REGEXP_REPLACE(OWA_UTIL.GET_CGI_ENV(REGEXP_SUBSTR(str, ''[^,]+'', 1, LEVEL)), ''([;)])'', ''\1''',
') AS value',
'FROM t',
'CONNECT BY LEVEL <= REGEXP_COUNT(str, '','')',
'ORDER BY 1;',
''))
,p_ajax_enabled=>'Y'
,p_lazy_loading=>false
,p_query_row_template=>wwv_flow_api.id(9115257435569961)
,p_query_num_rows=>100
,p_query_options=>'DERIVED_REPORT_COLUMNS'
,p_csv_output=>'N'
,p_prn_output=>'N'
,p_sort_null=>'L'
,p_plug_query_strip_html=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(17062953302582715)
,p_query_column_id=>1
,p_column_alias=>'NAME'
,p_column_display_sequence=>10
,p_column_heading=>'Name'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(17063041292582716)
,p_query_column_id=>2
,p_column_alias=>'VALUE'
,p_column_display_sequence=>20
,p_column_heading=>'Value'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(17063109437582717)
,p_plug_name=>'USERENV'
,p_parent_plug_id=>wwv_flow_api.id(16222516003514114)
,p_region_template_options=>'#DEFAULT#:t-HeroRegion--hideIcon'
,p_region_attributes=>'style="margin-top: -1rem;"'
,p_plug_template=>wwv_flow_api.id(9070356145569920)
,p_plug_display_sequence=>90
,p_plug_new_grid_row=>false
,p_plug_grid_column_span=>4
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(17063289732582718)
,p_plug_name=>'NLS'
,p_parent_plug_id=>wwv_flow_api.id(16222516003514114)
,p_region_template_options=>'#DEFAULT#:t-HeroRegion--hideIcon'
,p_region_attributes=>'style="margin-top: -1rem;"'
,p_plug_template=>wwv_flow_api.id(9070356145569920)
,p_plug_display_sequence=>80
,p_plug_grid_column_span=>4
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_report_region(
 p_id=>wwv_flow_api.id(17063357118582719)
,p_name=>'NLS [DATA]'
,p_parent_plug_id=>wwv_flow_api.id(16222516003514114)
,p_template=>wwv_flow_api.id(9078290074569925)
,p_display_sequence=>110
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#:t-AVPList--fixedLabelLarge:t-AVPList--leftAligned:t-Report--hideNoPagination'
,p_grid_column_span=>4
,p_display_point=>'BODY'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT',
'    n.parameter,',
'    n.value',
'FROM nls_session_parameters n',
'ORDER BY 1;',
''))
,p_ajax_enabled=>'Y'
,p_lazy_loading=>false
,p_query_row_template=>wwv_flow_api.id(9115257435569961)
,p_query_num_rows=>100
,p_query_options=>'DERIVED_REPORT_COLUMNS'
,p_csv_output=>'N'
,p_prn_output=>'N'
,p_sort_null=>'L'
,p_plug_query_strip_html=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(17063972173582725)
,p_query_column_id=>1
,p_column_alias=>'PARAMETER'
,p_column_display_sequence=>30
,p_column_heading=>'Parameter'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(17063536602582721)
,p_query_column_id=>2
,p_column_alias=>'VALUE'
,p_column_display_sequence=>20
,p_column_heading=>'Value'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_region(
 p_id=>wwv_flow_api.id(17063670953582722)
,p_name=>'USERENV [DATA]'
,p_parent_plug_id=>wwv_flow_api.id(16222516003514114)
,p_template=>wwv_flow_api.id(9078290074569925)
,p_display_sequence=>120
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#:t-AVPList--fixedLabelMedium:t-AVPList--leftAligned:t-Report--hideNoPagination'
,p_region_attributes=>'style="overflow-x: hidden;"'
,p_new_grid_row=>false
,p_grid_column_span=>4
,p_display_point=>'BODY'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'WITH t AS (',
'    SELECT',
'        ''CLIENT_IDENTIFIER,CLIENT_INFO,ACTION,MODULE,'' ||',
'        ''CURRENT_SCHEMA,CURRENT_USER,CURRENT_EDITION_ID,CURRENT_EDITION_NAME,'' ||',
'        ''OS_USER,POLICY_INVOKER,'' ||',
'        ''SESSION_USER,SESSIONID,SID,SESSION_EDITION_ID,SESSION_EDITION_NAME,'' ||',
'        ''AUTHENTICATED_IDENTITY,AUTHENTICATION_DATA,AUTHENTICATION_METHOD,IDENTIFICATION_TYPE,'' ||',
'        ''ENTERPRISE_IDENTITY,PROXY_ENTERPRISE_IDENTITY,PROXY_USER,'' ||',
'        ''GLOBAL_CONTEXT_MEMORY,GLOBAL_UID,'' ||',
'        ''AUDITED_CURSORID,ENTRYID,STATEMENTID,CURRENT_SQL,CURRENT_BIND,'' ||',
'        ''HOST,SERVER_HOST,SERVICE_NAME,IP_ADDRESS,'' ||',
'        ''DB_DOMAIN,DB_NAME,DB_UNIQUE_NAME,DBLINK_INFO,DATABASE_ROLE,ISDBA,'' ||',
'        ''INSTANCE,INSTANCE_NAME,NETWORK_PROTOCOL,'' ||',
'        ''LANG,LANGUAGE,'' || --,NLS_TERRITORY,NLS_CURRENCY,NLS_SORT,NLS_DATE_FORMAT,NLS_DATE_LANGUAGE,NLS_CALENDAR,'' ||',
'        ''BG_JOB_ID,FG_JOB_ID'' AS str',
'    FROM DUAL',
')',
'SELECT',
'    t.name,',
'    t.value',
'FROM (',
'    SELECT',
'        REGEXP_SUBSTR(str, ''[^,]+'', 1, LEVEL) AS name,',
'        SYS_CONTEXT(''USERENV'', REGEXP_SUBSTR(str, ''[^,]+'', 1, LEVEL)) AS value',
'    FROM t',
'    CONNECT BY LEVEL <= REGEXP_COUNT(str, '','')',
') t',
'WHERE t.value IS NOT NULL',
'ORDER BY 1;'))
,p_ajax_enabled=>'Y'
,p_lazy_loading=>false
,p_query_row_template=>wwv_flow_api.id(9115257435569961)
,p_query_num_rows=>100
,p_query_options=>'DERIVED_REPORT_COLUMNS'
,p_csv_output=>'N'
,p_prn_output=>'N'
,p_sort_null=>'L'
,p_plug_query_strip_html=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(17063733186582723)
,p_query_column_id=>1
,p_column_alias=>'NAME'
,p_column_display_sequence=>10
,p_column_heading=>'Name'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(17063809834582724)
,p_query_column_id=>2
,p_column_alias=>'VALUE'
,p_column_display_sequence=>20
,p_column_heading=>'Value'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(22939890463325303)
,p_plug_name=>'TRANSLATIONS'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(9049155795569902)
,p_plug_display_sequence=>20
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'REGION_POSITION_05'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'NEVER'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(16470096407696748)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(16222425620514113)
,p_button_name=>'SHOW_REQUEST_LOG'
,p_button_action=>'REDIRECT_URL'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(9144574670569995)
,p_button_image_alt=>'Show Request Log'
,p_button_position=>'RIGHT_OF_TITLE'
,p_button_redirect_url=>'javascript:window.open(''&P0_REQUEST_LOG.'', ''_blank'');'
,p_button_execute_validations=>'N'
,p_icon_css_classes=>'fa-bug'
,p_button_cattributes=>'target="_blank"'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(17061889596582704)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(16222425620514113)
,p_button_name=>'SHOW_NAVIGATION'
,p_button_action=>'REDIRECT_URL'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(9144574670569995)
,p_button_image_alt=>'Show Navigation'
,p_button_position=>'RIGHT_OF_TITLE'
,p_button_redirect_url=>'javascript:window.open(''&P0_NAVIGATION.'', ''_blank'');'
,p_button_execute_validations=>'N'
,p_icon_css_classes=>'fa-map-signs'
,p_button_cattributes=>'target="_blank"'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(17061664291582702)
,p_name=>'P0_REQUEST_LOG'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(16222425620514113)
,p_use_cache_before_default=>'NO'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'app.get_page_link(901,',
'    in_names    => ''P901_LOG_ID'',',
'    in_values   => app.get_log_request_id()',
')'))
,p_source_type=>'EXPRESSION'
,p_source_language=>'PLSQL'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(17061957126582705)
,p_name=>'P0_NAVIGATION'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(16222425620514113)
,p_use_cache_before_default=>'NO'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'app.get_page_link(910,',
'    in_names    => ''P910_PAGE_ID'',',
'    in_values   => app.get_page_id()',
')'))
,p_source_type=>'EXPRESSION'
,p_source_language=>'PLSQL'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(11425112951377811)
,p_name=>'ON_LOAD'
,p_event_sequence=>10
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(11425241361377812)
,p_event_id=>wwv_flow_api.id(11425112951377811)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'// manipulate grids',
'// specifically change Save button style on grid change',
'apex_page_loaded();',
''))
);
wwv_flow_api.component_end;
end;
/
