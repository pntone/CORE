prompt --application/pages/page_00922
begin
--   Manifest
--     PAGE: 00922
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
 p_id=>922
,p_user_interface_id=>wwv_flow_api.id(9169746885570061)
,p_name=>'#fa-map-o Applications'
,p_alias=>'APPS'
,p_step_title=>'Applications'
,p_autocomplete_on_off=>'OFF'
,p_group_id=>wwv_flow_api.id(9240371448352386)
,p_page_css_classes=>'USER_NAME'
,p_page_template_options=>'#DEFAULT#'
,p_required_role=>wwv_flow_api.id(9556407311505078)
,p_last_updated_by=>'DEV'
,p_last_upd_yyyymmddhh24miss=>'20220102202508'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(26299859420563564)
,p_plug_name=>'Available Applications [CARDS]'
,p_region_template_options=>'#DEFAULT#:margin-left-md:margin-right-md'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(9052354744569904)
,p_plug_display_sequence=>20
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_new_grid_row=>false
,p_plug_new_grid_column=>false
,p_plug_display_point=>'BODY'
,p_query_type=>'TABLE'
,p_query_table=>'USERS_APPS'
,p_query_where=>'is_available = ''Y'''
,p_query_order_by=>'APP_ID'
,p_include_rowid_column=>false
,p_lazy_loading=>false
,p_plug_source_type=>'NATIVE_CARDS'
,p_plug_query_num_rows_type=>'SCROLL'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_show_total_row_count=>false
,p_plug_footer=>'<br />'
);
wwv_flow_api.create_card(
 p_id=>wwv_flow_api.id(13306848907626674)
,p_region_id=>wwv_flow_api.id(26299859420563564)
,p_layout_type=>'GRID'
,p_grid_column_count=>5
,p_title_adv_formatting=>false
,p_title_column_name=>'APP_NAME'
,p_sub_title_adv_formatting=>false
,p_sub_title_column_name=>'AUTHENTICATION_SCHEME'
,p_body_adv_formatting=>false
,p_body_column_name=>'DESCRIPTION_'
,p_second_body_adv_formatting=>false
,p_second_body_column_name=>'MESSAGE'
,p_badge_column_name=>'COUNT_PAGES'
,p_media_adv_formatting=>false
,p_pk1_column_name=>'APP_ID'
);
wwv_flow_api.create_card_action(
 p_id=>wwv_flow_api.id(13307346821626675)
,p_card_id=>wwv_flow_api.id(13306848907626674)
,p_action_type=>'FULL_CARD'
,p_display_sequence=>10
,p_link_target_type=>'REDIRECT_URL'
,p_link_target=>'&APP_URL.'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(26300056728563566)
,p_plug_name=>'Available Applications'
,p_icon_css_classes=>'fa-map-signs'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(9070356145569920)
,p_plug_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(26300226699563568)
,p_plug_name=>'Applications [GRID]'
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(9078290074569925)
,p_plug_display_sequence=>40
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_query_type=>'TABLE'
,p_query_table=>'USERS_APPS'
,p_include_rowid_column=>false
,p_plug_source_type=>'NATIVE_IG'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_required_role=>wwv_flow_api.id(9556407311505078)
,p_prn_content_disposition=>'ATTACHMENT'
,p_prn_document_header=>'APEX'
,p_prn_units=>'MILLIMETERS'
,p_prn_paper_size=>'A4'
,p_prn_width=>297
,p_prn_height=>210
,p_prn_orientation=>'HORIZONTAL'
,p_prn_page_header=>'Applications [GRID]'
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
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(13238198091910318)
,p_name=>'APP_URL'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'APP_URL'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>true
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>140
,p_attribute_01=>'Y'
,p_filter_is_required=>false
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_is_primary_key=>false
,p_include_in_export=>false
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(13238361460910320)
,p_name=>'APP_ALIAS'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'APP_ALIAS'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>true
,p_item_type=>'NATIVE_DISPLAY_ONLY'
,p_heading=>'App Alias'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>70
,p_value_alignment=>'LEFT'
,p_attribute_02=>'VALUE'
,p_attribute_05=>'PLAIN'
,p_link_target=>'&APP_URL.'
,p_link_text=>'&APP_ALIAS.'
,p_enable_filter=>true
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
,p_filter_is_required=>false
,p_filter_text_case=>'MIXED'
,p_filter_lov_type=>'NONE'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(13238449492910321)
,p_name=>'APP_GROUP'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'APP_GROUP'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>true
,p_item_type=>'NATIVE_DISPLAY_ONLY'
,p_heading=>'App Group'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>80
,p_value_alignment=>'LEFT'
,p_attribute_02=>'VALUE'
,p_attribute_05=>'PLAIN'
,p_enable_filter=>true
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
,p_filter_is_required=>false
,p_filter_text_case=>'MIXED'
,p_filter_lov_type=>'NONE'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(13238552404910322)
,p_name=>'APP_SCHEMA'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'APP_SCHEMA'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>true
,p_item_type=>'NATIVE_DISPLAY_ONLY'
,p_heading=>'App Schema'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>90
,p_value_alignment=>'LEFT'
,p_attribute_02=>'VALUE'
,p_attribute_05=>'PLAIN'
,p_enable_filter=>true
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
,p_filter_is_required=>false
,p_filter_text_case=>'MIXED'
,p_filter_lov_type=>'NONE'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(13238675149910323)
,p_name=>'AUTHENTICATION_SCHEME'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'AUTHENTICATION_SCHEME'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>true
,p_item_type=>'NATIVE_DISPLAY_ONLY'
,p_heading=>'Authentication'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>110
,p_value_alignment=>'LEFT'
,p_attribute_02=>'VALUE'
,p_attribute_05=>'PLAIN'
,p_enable_filter=>true
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
,p_filter_is_required=>false
,p_filter_text_case=>'MIXED'
,p_filter_lov_type=>'NONE'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(13238724010910324)
,p_name=>'LAST_UPDATED_ON'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'LAST_UPDATED_ON'
,p_data_type=>'DATE'
,p_is_query_only=>true
,p_item_type=>'NATIVE_DISPLAY_ONLY'
,p_heading=>'Last Updated'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>120
,p_value_alignment=>'CENTER'
,p_attribute_02=>'VALUE'
,p_attribute_05=>'PLAIN'
,p_format_mask=>'YYYY-MM-DD HH24:MI'
,p_enable_filter=>true
,p_filter_is_required=>false
,p_filter_date_ranges=>'ALL'
,p_filter_lov_type=>'DISTINCT'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(13238855959910325)
,p_name=>'COUNT_PAGES'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'COUNT_PAGES'
,p_data_type=>'NUMBER'
,p_is_query_only=>true
,p_item_type=>'NATIVE_DISPLAY_ONLY'
,p_heading=>'Pages'
,p_heading_alignment=>'RIGHT'
,p_display_sequence=>130
,p_value_alignment=>'RIGHT'
,p_attribute_02=>'VALUE'
,p_attribute_05=>'PLAIN'
,p_enable_filter=>true
,p_filter_is_required=>false
,p_filter_lov_type=>'NONE'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(13238943813910326)
,p_name=>'IS_ACTIVE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'IS_ACTIVE'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_SINGLE_CHECKBOX'
,p_heading=>'Is Active'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>150
,p_value_alignment=>'CENTER'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_is_required=>false
,p_enable_filter=>true
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
,p_filter_is_required=>false
,p_filter_text_case=>'MIXED'
,p_filter_exact_match=>true
,p_filter_lov_type=>'DISTINCT'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(13239398809910330)
,p_name=>'IS_AVAILABLE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'IS_AVAILABLE'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>true
,p_item_type=>'NATIVE_SINGLE_CHECKBOX'
,p_heading=>'Is Available'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>170
,p_value_alignment=>'CENTER'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_is_required=>false
,p_enable_filter=>true
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
,p_filter_is_required=>false
,p_filter_text_case=>'MIXED'
,p_filter_exact_match=>true
,p_filter_lov_type=>'DISTINCT'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(13762648854460503)
,p_name=>'ACTION'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'ACTION'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>true
,p_item_type=>'NATIVE_HTML_EXPRESSION'
,p_heading=>'Action'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>30
,p_value_alignment=>'CENTER'
,p_attribute_01=>'&ACTION.'
,p_link_target=>'f?p=&APP_ID.:922:&SESSION.::&DEBUG.::P922_ADD_APP:&ACTION_ID.#APP_ID#'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(13762725809460504)
,p_name=>'APP_VERSION'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'APP_VERSION'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>true
,p_item_type=>'NATIVE_DISPLAY_ONLY'
,p_heading=>'App Version'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>100
,p_value_alignment=>'LEFT'
,p_attribute_02=>'VALUE'
,p_attribute_05=>'PLAIN'
,p_enable_filter=>true
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
,p_filter_is_required=>false
,p_filter_text_case=>'MIXED'
,p_filter_lov_type=>'NONE'
,p_use_as_row_header=>false
,p_enable_sort_group=>false
,p_enable_hide=>true
,p_is_primary_key=>false
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(13763107512460508)
,p_name=>'ACTION_ID'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'ACTION_ID'
,p_data_type=>'NUMBER'
,p_is_query_only=>true
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>40
,p_attribute_01=>'Y'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_is_primary_key=>false
,p_include_in_export=>false
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(13948630310822412)
,p_name=>'IS_OFFLINE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'IS_OFFLINE'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>true
,p_item_type=>'NATIVE_SINGLE_CHECKBOX'
,p_heading=>'Is Offline'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>180
,p_value_alignment=>'CENTER'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_is_required=>false
,p_enable_filter=>true
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
,p_filter_is_required=>false
,p_filter_text_case=>'MIXED'
,p_filter_exact_match=>true
,p_filter_lov_type=>'DISTINCT'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_include_in_export=>true
,p_readonly_condition_type=>'ALWAYS'
,p_readonly_for_each_row=>false
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(26300438565563570)
,p_name=>'APP_ID'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'APP_ID'
,p_data_type=>'NUMBER'
,p_is_query_only=>false
,p_item_type=>'NATIVE_NUMBER_FIELD'
,p_heading=>'App Id'
,p_heading_alignment=>'RIGHT'
,p_display_sequence=>50
,p_value_alignment=>'RIGHT'
,p_attribute_03=>'right'
,p_is_required=>false
,p_enable_filter=>true
,p_filter_is_required=>false
,p_filter_lov_type=>'NONE'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>true
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(26300535049563571)
,p_name=>'APP_NAME'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'APP_NAME'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXT_FIELD'
,p_heading=>'App Name'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>60
,p_value_alignment=>'LEFT'
,p_attribute_05=>'BOTH'
,p_is_required=>false
,p_max_length=>255
,p_enable_filter=>true
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
,p_filter_is_required=>false
,p_filter_text_case=>'MIXED'
,p_filter_exact_match=>true
,p_filter_lov_type=>'DISTINCT'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(26300620422563572)
,p_name=>'MESSAGE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'MESSAGE'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXT_FIELD'
,p_heading=>'Message'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>200
,p_value_alignment=>'LEFT'
,p_attribute_05=>'BOTH'
,p_is_required=>false
,p_max_length=>256
,p_enable_filter=>true
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
,p_filter_is_required=>false
,p_filter_text_case=>'MIXED'
,p_filter_lov_type=>'NONE'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(26300804038563574)
,p_name=>'IS_VISIBLE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'IS_VISIBLE'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_SINGLE_CHECKBOX'
,p_heading=>'Is Visible'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>160
,p_value_alignment=>'CENTER'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_is_required=>false
,p_enable_filter=>true
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
,p_filter_is_required=>false
,p_filter_text_case=>'MIXED'
,p_filter_exact_match=>true
,p_filter_lov_type=>'DISTINCT'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(26301098134563577)
,p_name=>'APEX$ROW_ACTION'
,p_item_type=>'NATIVE_ROW_ACTION'
,p_display_sequence=>20
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(26301206933563578)
,p_name=>'APEX$ROW_SELECTOR'
,p_item_type=>'NATIVE_ROW_SELECTOR'
,p_display_sequence=>10
,p_attribute_01=>'Y'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(26301575771563582)
,p_name=>'DESCRIPTION_'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'DESCRIPTION_'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXT_FIELD'
,p_heading=>'Description'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>190
,p_value_alignment=>'LEFT'
,p_attribute_05=>'BOTH'
,p_is_required=>false
,p_max_length=>1000
,p_enable_filter=>true
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
,p_filter_is_required=>false
,p_filter_text_case=>'MIXED'
,p_filter_lov_type=>'NONE'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_interactive_grid(
 p_id=>wwv_flow_api.id(26300277281563569)
,p_internal_uid=>26300277281563569
,p_is_editable=>true
,p_edit_operations=>'i:u:d'
,p_add_authorization_scheme=>wwv_flow_api.id(9556407311505078)
,p_update_authorization_scheme=>wwv_flow_api.id(9556407311505078)
,p_delete_authorization_scheme=>wwv_flow_api.id(9556407311505078)
,p_lost_update_check_type=>'VALUES'
,p_add_row_if_empty=>false
,p_submit_checked_rows=>false
,p_lazy_loading=>false
,p_requires_filter=>false
,p_select_first_row=>false
,p_fixed_row_height=>true
,p_pagination_type=>'SET'
,p_show_total_row_count=>true
,p_show_toolbar=>true
,p_toolbar_buttons=>'SEARCH_COLUMN:SEARCH_FIELD:ACTIONS_MENU:SAVE'
,p_enable_save_public_report=>false
,p_enable_subscriptions=>true
,p_enable_flashback=>true
,p_define_chart_view=>true
,p_enable_download=>true
,p_download_formats=>'CSV:HTML:XLSX:PDF'
,p_enable_mail_download=>true
,p_fixed_header=>'PAGE'
,p_show_icon_view=>false
,p_show_detail_view=>false
,p_javascript_code=>wwv_flow_string.join(wwv_flow_t_varchar2(
'function(config) {',
'    return unified_ig_toolbar(config);',
'}',
''))
);
wwv_flow_api.create_ig_report(
 p_id=>wwv_flow_api.id(26363568934031310)
,p_interactive_grid_id=>wwv_flow_api.id(26300277281563569)
,p_static_id=>'130585'
,p_type=>'PRIMARY'
,p_default_view=>'GRID'
,p_rows_per_page=>20
,p_show_row_number=>false
,p_settings_area_expanded=>false
);
wwv_flow_api.create_ig_report_view(
 p_id=>wwv_flow_api.id(26363836961031310)
,p_report_id=>wwv_flow_api.id(26363568934031310)
,p_view_type=>'GRID'
,p_stretch_columns=>true
,p_srv_exclude_null_values=>false
,p_srv_only_display_columns=>true
,p_edit_mode=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(13361667551007396)
,p_view_id=>wwv_flow_api.id(26363836961031310)
,p_display_seq=>11
,p_column_id=>wwv_flow_api.id(13238198091910318)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(13366471452095484)
,p_view_id=>wwv_flow_api.id(26363836961031310)
,p_display_seq=>3
,p_column_id=>wwv_flow_api.id(13238361460910320)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>120
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(13367333658095487)
,p_view_id=>wwv_flow_api.id(26363836961031310)
,p_display_seq=>13
,p_column_id=>wwv_flow_api.id(13238449492910321)
,p_is_visible=>false
,p_is_frozen=>false
,p_break_order=>5
,p_break_is_enabled=>true
,p_break_sort_direction=>'ASC'
,p_break_sort_nulls=>'LAST'
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(13368105714095493)
,p_view_id=>wwv_flow_api.id(26363836961031310)
,p_display_seq=>3
,p_column_id=>wwv_flow_api.id(13238552404910322)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>120
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(13369076592095496)
,p_view_id=>wwv_flow_api.id(26363836961031310)
,p_display_seq=>14
,p_column_id=>wwv_flow_api.id(13238675149910323)
,p_is_visible=>false
,p_is_frozen=>false
,p_width=>200
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(13369966686095498)
,p_view_id=>wwv_flow_api.id(26363836961031310)
,p_display_seq=>16
,p_column_id=>wwv_flow_api.id(13238724010910324)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>160
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(13370811484095500)
,p_view_id=>wwv_flow_api.id(26363836961031310)
,p_display_seq=>15
,p_column_id=>wwv_flow_api.id(13238855959910325)
,p_is_visible=>false
,p_is_frozen=>false
,p_width=>80
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(13371761504095502)
,p_view_id=>wwv_flow_api.id(26363836961031310)
,p_display_seq=>6
,p_column_id=>wwv_flow_api.id(13238943813910326)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>90
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(13454531437412331)
,p_view_id=>wwv_flow_api.id(26363836961031310)
,p_display_seq=>8
,p_column_id=>wwv_flow_api.id(13239398809910330)
,p_is_visible=>false
,p_is_frozen=>false
,p_width=>120
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(13786530674732320)
,p_view_id=>wwv_flow_api.id(26363836961031310)
,p_display_seq=>2
,p_column_id=>wwv_flow_api.id(13762648854460503)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>80
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(13809009083747983)
,p_view_id=>wwv_flow_api.id(26363836961031310)
,p_display_seq=>17
,p_column_id=>wwv_flow_api.id(13762725809460504)
,p_is_visible=>false
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(13823959151931426)
,p_view_id=>wwv_flow_api.id(26363836961031310)
,p_display_seq=>17
,p_column_id=>wwv_flow_api.id(13763107512460508)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(13961356873703903)
,p_view_id=>wwv_flow_api.id(26363836961031310)
,p_display_seq=>9
,p_column_id=>wwv_flow_api.id(13948630310822412)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>90
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(26364302191031312)
,p_view_id=>wwv_flow_api.id(26363836961031310)
,p_display_seq=>4
,p_column_id=>wwv_flow_api.id(26300438565563570)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>90
,p_sort_order=>1
,p_sort_direction=>'ASC'
,p_sort_nulls=>'LAST'
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(26365259909031315)
,p_view_id=>wwv_flow_api.id(26363836961031310)
,p_display_seq=>5
,p_column_id=>wwv_flow_api.id(26300535049563571)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>300
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(26366090725031318)
,p_view_id=>wwv_flow_api.id(26363836961031310)
,p_display_seq=>12
,p_column_id=>wwv_flow_api.id(26300620422563572)
,p_is_visible=>false
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(26367945968031323)
,p_view_id=>wwv_flow_api.id(26363836961031310)
,p_display_seq=>7
,p_column_id=>wwv_flow_api.id(26300804038563574)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>90
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(26370592837031330)
,p_view_id=>wwv_flow_api.id(26363836961031310)
,p_display_seq=>0
,p_column_id=>wwv_flow_api.id(26301098134563577)
,p_is_visible=>true
,p_is_frozen=>true
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(26392371935115982)
,p_view_id=>wwv_flow_api.id(26363836961031310)
,p_display_seq=>10
,p_column_id=>wwv_flow_api.id(26301575771563582)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(26301380227563580)
,p_plug_name=>'Applications'
,p_icon_css_classes=>'fa-map-o'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(9070356145569920)
,p_plug_display_sequence=>30
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_required_role=>wwv_flow_api.id(9556407311505078)
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(13305755030626665)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(26301380227563580)
,p_button_name=>'REFRESH'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(9144574670569995)
,p_button_image_alt=>'Refresh'
,p_button_position=>'RIGHT_OF_TITLE'
,p_button_redirect_url=>'f?p=&APP_ID.:922:&SESSION.::&DEBUG.:922::'
,p_icon_css_classes=>'fa-refresh'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(13306121129626670)
,p_name=>'P922_SWITCH_APP'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(26301380227563580)
,p_prompt=>'Switch Application'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT',
'    a.app_name,',
'    a.app_id',
'FROM users_apps a',
'ORDER BY a.app_id;'))
,p_lov_display_null=>'YES'
,p_cHeight=>1
,p_colspan=>6
,p_display_when_type=>'NEVER'
,p_field_template=>wwv_flow_api.id(9142775823569991)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(13762969501460506)
,p_name=>'P922_ADD_APP'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(26301380227563580)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_computation(
 p_id=>wwv_flow_api.id(13321710322626701)
,p_computation_sequence=>10
,p_computation_item=>'P922_SWITCH_APP'
,p_computation_point=>'BEFORE_BOX_BODY'
,p_computation_type=>'EXPRESSION'
,p_computation_language=>'PLSQL'
,p_computation=>'app.get_app_id()'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(13322478357626702)
,p_name=>'ON_CHANGE'
,p_event_sequence=>10
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P922_SWITCH_APP'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(13322992028626703)
,p_event_id=>wwv_flow_api.id(13322478357626702)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'app.log_action(''SWITCH_APP'', :P922_SWITCH_APP);',
'--',
'UPDATE sessions s',
'SET s.updated_at        = SYSDATE',
'WHERE s.app_id          = :P922_SWITCH_APP',
'    AND s.session_id    = app.get_session_id();',
''))
,p_attribute_02=>'P922_SWITCH_APP'
,p_attribute_05=>'PLSQL'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(13323452671626703)
,p_event_id=>wwv_flow_api.id(13322478357626702)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SUBMIT_PAGE'
,p_attribute_02=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(13323891779626704)
,p_name=>'CHANGE_PROXY'
,p_event_sequence=>10
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P922_PROXY'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(13324326107626704)
,p_event_id=>wwv_flow_api.id(13323891779626704)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'UPDATE sessions s',
'SET s.updated_at        = SYSDATE',
'WHERE s.app_id          = :P922_PROXY',
'    AND s.session_id    = app.get_session_id();',
''))
,p_attribute_02=>'P922_PROXY'
,p_attribute_05=>'PLSQL'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(13324856625626704)
,p_event_id=>wwv_flow_api.id(13323891779626704)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SUBMIT_PAGE'
,p_attribute_02=>'Y'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(13312549811626688)
,p_process_sequence=>20
,p_process_point=>'AFTER_SUBMIT'
,p_region_id=>wwv_flow_api.id(26300226699563568)
,p_process_type=>'NATIVE_IG_DML'
,p_process_name=>'SAVE_APPLICATIONS'
,p_attribute_01=>'TABLE'
,p_attribute_03=>'APPS'
,p_attribute_05=>'Y'
,p_attribute_06=>'N'
,p_attribute_08=>'Y'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(13763050870460507)
,p_process_sequence=>10
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'ADD_APP'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'IF :P922_ADD_APP IS NOT NULL THEN',
'    app.log_action(''ADD_APP'', :P922_ADD_APP);',
'    --',
'    BEGIN',
'        INSERT INTO apps (app_id)',
'        VALUES (',
'            :P922_ADD_APP',
'        );',
'    END;',
'END IF;',
'--',
':P922_ADD_APP := NULL;',
''))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when=>'P922_ADD_APP'
,p_process_when_type=>'ITEM_IS_NOT_NULL'
);
wwv_flow_api.component_end;
end;
/
