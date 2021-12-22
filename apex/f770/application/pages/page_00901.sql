prompt --application/pages/page_00901
begin
--   Manifest
--     PAGE: 00901
--   Manifest End
wwv_flow_api.component_begin (
 p_version_yyyy_mm_dd=>'2021.04.15'
,p_release=>'21.1.6'
,p_default_workspace_id=>9014660246496943
,p_default_application_id=>770
,p_default_id_offset=>0
,p_default_owner=>'CORE'
);
wwv_flow_api.create_page(
 p_id=>901
,p_user_interface_id=>wwv_flow_api.id(9169746885570061)
,p_name=>'#fa-bug Logs'
,p_alias=>'LOGS'
,p_step_title=>'Logs'
,p_autocomplete_on_off=>'OFF'
,p_group_id=>wwv_flow_api.id(9240371448352386)
,p_page_template_options=>'#DEFAULT#'
,p_required_role=>wwv_flow_api.id(9556407311505078)
,p_last_updated_by=>'DEV'
,p_last_upd_yyyymmddhh24miss=>'20211222211412'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(9262174270429022)
,p_plug_name=>'Logs'
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(9078290074569925)
,p_plug_display_sequence=>20
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_query_type=>'TABLE'
,p_query_table=>'LOGS'
,p_include_rowid_column=>false
,p_plug_source_type=>'NATIVE_IR'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_prn_units=>'INCHES'
,p_prn_paper_size=>'LETTER'
,p_prn_width=>11
,p_prn_height=>8.5
,p_prn_orientation=>'HORIZONTAL'
,p_prn_page_header=>'Logs'
,p_prn_page_header_font_color=>'#000000'
,p_prn_page_header_font_family=>'Helvetica'
,p_prn_page_header_font_weight=>'normal'
,p_prn_page_header_font_size=>'12'
,p_prn_page_footer_font_color=>'#000000'
,p_prn_page_footer_font_family=>'Helvetica'
,p_prn_page_footer_font_weight=>'normal'
,p_prn_page_footer_font_size=>'12'
,p_prn_header_bg_color=>'#EEEEEE'
,p_prn_header_font_color=>'#000000'
,p_prn_header_font_family=>'Helvetica'
,p_prn_header_font_weight=>'bold'
,p_prn_header_font_size=>'10'
,p_prn_body_bg_color=>'#FFFFFF'
,p_prn_body_font_color=>'#000000'
,p_prn_body_font_family=>'Helvetica'
,p_prn_body_font_weight=>'normal'
,p_prn_body_font_size=>'10'
,p_prn_border_width=>.5
,p_prn_page_header_alignment=>'CENTER'
,p_prn_page_footer_alignment=>'CENTER'
,p_prn_border_color=>'#666666'
);
wwv_flow_api.create_worksheet(
 p_id=>wwv_flow_api.id(9262362978429024)
,p_max_row_count=>'1000000'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_lazy_loading=>false
,p_show_detail_link=>'N'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:XLSX:PDF:RTF:EMAIL'
,p_owner=>'DEV'
,p_internal_uid=>9262362978429024
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(9262479035429025)
,p_db_column_name=>'LOG_ID'
,p_display_order=>10
,p_column_identifier=>'A'
,p_column_label=>'Log Id'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(9262529818429026)
,p_db_column_name=>'LOG_PARENT'
,p_display_order=>20
,p_column_identifier=>'B'
,p_column_label=>'Log Parent'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(9262634869429027)
,p_db_column_name=>'APP_ID'
,p_display_order=>30
,p_column_identifier=>'C'
,p_column_label=>'App Id'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(9262755694429028)
,p_db_column_name=>'PAGE_ID'
,p_display_order=>40
,p_column_identifier=>'D'
,p_column_label=>'Page Id'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(9262818925429029)
,p_db_column_name=>'USER_ID'
,p_display_order=>50
,p_column_identifier=>'E'
,p_column_label=>'User Id'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(9262953214429030)
,p_db_column_name=>'FLAG'
,p_display_order=>60
,p_column_identifier=>'F'
,p_column_label=>'Flag'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(9263061701429031)
,p_db_column_name=>'ACTION_NAME'
,p_display_order=>70
,p_column_identifier=>'G'
,p_column_label=>'Action Name'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(9263182675429032)
,p_db_column_name=>'MODULE_NAME'
,p_display_order=>80
,p_column_identifier=>'H'
,p_column_label=>'Module Name'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(9263258921429033)
,p_db_column_name=>'MODULE_LINE'
,p_display_order=>90
,p_column_identifier=>'I'
,p_column_label=>'Module Line'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(9263316194429034)
,p_db_column_name=>'MODULE_TIME'
,p_display_order=>100
,p_column_identifier=>'J'
,p_column_label=>'Module Time'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(9263403995429035)
,p_db_column_name=>'ARGUMENTS'
,p_display_order=>110
,p_column_identifier=>'K'
,p_column_label=>'Arguments'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(9263561064429036)
,p_db_column_name=>'PAYLOAD'
,p_display_order=>120
,p_column_identifier=>'L'
,p_column_label=>'Payload'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(9263677293429037)
,p_db_column_name=>'SESSION_ID'
,p_display_order=>130
,p_column_identifier=>'M'
,p_column_label=>'Session Id'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(9263707678429038)
,p_db_column_name=>'CREATED_AT'
,p_display_order=>140
,p_column_identifier=>'N'
,p_column_label=>'Created At'
,p_column_type=>'DATE'
,p_column_alignment=>'CENTER'
,p_format_mask=>'HH24:MI:SS'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(9435849057679293)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'94359'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'LOG_ID:LOG_PARENT:PAGE_ID:USER_ID:FLAG:ACTION_NAME:MODULE_NAME:MODULE_LINE:MODULE_TIME:ARGUMENTS:CREATED_AT:'
,p_sort_column_1=>'LOG_ID'
,p_sort_direction_1=>'DESC'
,p_sort_column_2=>'0'
,p_sort_direction_2=>'ASC'
,p_sort_column_3=>'0'
,p_sort_direction_3=>'ASC'
,p_sort_column_4=>'0'
,p_sort_direction_4=>'ASC'
,p_sort_column_5=>'0'
,p_sort_direction_5=>'ASC'
,p_sort_column_6=>'0'
,p_sort_direction_6=>'ASC'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(9263852973429039)
,p_plug_name=>'Logs'
,p_icon_css_classes=>'fa-bug'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(9070356145569920)
,p_plug_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.component_end;
end;
/