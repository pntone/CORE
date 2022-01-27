prompt --application/pages/page_00955
begin
--   Manifest
--     PAGE: 00955
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
 p_id=>955
,p_user_interface_id=>wwv_flow_api.id(9169746885570061)
,p_name=>'#fa-table-heart Views'
,p_alias=>'VIEWS'
,p_step_title=>'Views'
,p_autocomplete_on_off=>'OFF'
,p_group_id=>wwv_flow_api.id(15841923064543077)
,p_page_template_options=>'#DEFAULT#'
,p_required_role=>wwv_flow_api.id(9556407311505078)
,p_last_updated_by=>'DEV'
,p_last_upd_yyyymmddhh24miss=>'20220120215115'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(14220162747378949)
,p_plug_name=>'Views'
,p_icon_css_classes=>'fa-table-heart'
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
 p_id=>wwv_flow_api.id(14220223287378950)
,p_plug_name=>'Views [GRID]'
,p_region_name=>'VIEWS'
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(9078290074569925)
,p_plug_display_sequence=>20
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_query_type=>'TABLE'
,p_query_table=>'OBJ_VIEWS'
,p_include_rowid_column=>false
,p_plug_source_type=>'NATIVE_IG'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_prn_content_disposition=>'ATTACHMENT'
,p_prn_document_header=>'APEX'
,p_prn_units=>'MILLIMETERS'
,p_prn_paper_size=>'A4'
,p_prn_width=>297
,p_prn_height=>210
,p_prn_orientation=>'HORIZONTAL'
,p_prn_page_header=>'Views [GRID]'
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
wwv_flow_api.create_region_column_group(
 p_id=>wwv_flow_api.id(15339627237749828)
,p_heading=>'Usage'
);
wwv_flow_api.create_region_column_group(
 p_id=>wwv_flow_api.id(15339776986749829)
,p_heading=>'References'
);
wwv_flow_api.create_region_column_group(
 p_id=>wwv_flow_api.id(16023054809727215)
,p_heading=>'Flags'
);
wwv_flow_api.create_region_column_group(
 p_id=>wwv_flow_api.id(16465800743696706)
,p_heading=>'View Info'
);
wwv_flow_api.create_region_column_group(
 p_id=>wwv_flow_api.id(21541260254954406)
,p_heading=>'Count'
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(14929333603872302)
,p_name=>'VIEW_NAME'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'VIEW_NAME'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_DISPLAY_ONLY'
,p_heading=>'View Name'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>20
,p_value_alignment=>'LEFT'
,p_group_id=>wwv_flow_api.id(16465800743696706)
,p_use_group_for=>'BOTH'
,p_attribute_02=>'VALUE'
,p_attribute_05=>'PLAIN'
,p_link_target=>'f?p=&APP_ID.:961:&SESSION.::&DEBUG.:961:P961_VIEW_NAME:&VIEW_NAME.'
,p_link_text=>'&VIEW_NAME.'
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
 p_id=>wwv_flow_api.id(14929499065872303)
,p_name=>'REFERENCED_TABLES'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'REFERENCED_TABLES'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>true
,p_item_type=>'NATIVE_DISPLAY_ONLY'
,p_heading=>'Referenced Tables'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>70
,p_value_alignment=>'LEFT'
,p_group_id=>wwv_flow_api.id(15339776986749829)
,p_use_group_for=>'BOTH'
,p_attribute_05=>'HTML'
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
 p_id=>wwv_flow_api.id(14929507382872304)
,p_name=>'REFERENCED_VIEWS'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'REFERENCED_VIEWS'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>true
,p_item_type=>'NATIVE_DISPLAY_ONLY'
,p_heading=>'Referenced Views'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>80
,p_value_alignment=>'LEFT'
,p_group_id=>wwv_flow_api.id(15339776986749829)
,p_use_group_for=>'BOTH'
,p_attribute_05=>'HTML'
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
 p_id=>wwv_flow_api.id(14929621363872305)
,p_name=>'IS_READONLY'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'IS_READONLY'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_SINGLE_CHECKBOX'
,p_heading=>'Readonly'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>100
,p_value_alignment=>'CENTER'
,p_group_id=>wwv_flow_api.id(16023054809727215)
,p_use_group_for=>'BOTH'
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
 p_id=>wwv_flow_api.id(14929897471872307)
,p_name=>'LAST_DDL_TIME'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'LAST_DDL_TIME'
,p_data_type=>'DATE'
,p_is_query_only=>true
,p_item_type=>'NATIVE_DISPLAY_ONLY'
,p_heading=>'Last Ddl Time'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>130
,p_value_alignment=>'CENTER'
,p_attribute_02=>'VALUE'
,p_attribute_05=>'PLAIN'
,p_format_mask=>'&FORMAT_DATE_TIME.'
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
 p_id=>wwv_flow_api.id(14929952501872308)
,p_name=>'USED_IN_OBJECTS'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'USED_IN_OBJECTS'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>true
,p_item_type=>'NATIVE_DISPLAY_ONLY'
,p_heading=>'Used In Objects'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>50
,p_value_alignment=>'LEFT'
,p_group_id=>wwv_flow_api.id(15339627237749828)
,p_use_group_for=>'BOTH'
,p_attribute_05=>'HTML'
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
 p_id=>wwv_flow_api.id(14930051725872309)
,p_name=>'IS_DEFINER'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'IS_DEFINER'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>true
,p_item_type=>'NATIVE_SINGLE_CHECKBOX'
,p_heading=>'Definer'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>110
,p_value_alignment=>'CENTER'
,p_group_id=>wwv_flow_api.id(16023054809727215)
,p_use_group_for=>'BOTH'
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
 p_id=>wwv_flow_api.id(14930167492872310)
,p_name=>'USED_ON_PAGES'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'USED_ON_PAGES'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>true
,p_item_type=>'NATIVE_DISPLAY_ONLY'
,p_heading=>'Used On Pages'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>60
,p_value_alignment=>'LEFT'
,p_group_id=>wwv_flow_api.id(15339627237749828)
,p_use_group_for=>'BOTH'
,p_attribute_05=>'HTML'
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
 p_id=>wwv_flow_api.id(14930252402872311)
,p_name=>'VIEW_GROUP'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'VIEW_GROUP'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>true
,p_item_type=>'NATIVE_DISPLAY_ONLY'
,p_heading=>'View Group'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>10
,p_value_alignment=>'LEFT'
,p_group_id=>wwv_flow_api.id(16465800743696706)
,p_use_group_for=>'BOTH'
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
 p_id=>wwv_flow_api.id(16465704569696705)
,p_name=>'COUNT_LINES'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'COUNT_LINES'
,p_data_type=>'NUMBER'
,p_is_query_only=>false
,p_item_type=>'NATIVE_DISPLAY_ONLY'
,p_heading=>'Lines'
,p_heading_alignment=>'RIGHT'
,p_display_sequence=>40
,p_value_alignment=>'RIGHT'
,p_group_id=>wwv_flow_api.id(21541260254954406)
,p_use_group_for=>'BOTH'
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
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(16466877978696716)
,p_name=>'COMMENTS'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'COMMENTS'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_DISPLAY_ONLY'
,p_heading=>'Comments'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>120
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
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(21541015139954404)
,p_name=>'COUNT_COLUMNS'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'COUNT_COLUMNS'
,p_data_type=>'NUMBER'
,p_is_query_only=>true
,p_item_type=>'NATIVE_DISPLAY_ONLY'
,p_heading=>'Columns'
,p_heading_alignment=>'RIGHT'
,p_display_sequence=>30
,p_value_alignment=>'RIGHT'
,p_group_id=>wwv_flow_api.id(21541260254954406)
,p_use_group_for=>'BOTH'
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
 p_id=>wwv_flow_api.id(21541103407954405)
,p_name=>'LIST_COLUMNS'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'LIST_COLUMNS'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>true
,p_item_type=>'NATIVE_DISPLAY_ONLY'
,p_heading=>'List Columns'
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
,p_enable_sort_group=>false
,p_enable_hide=>true
,p_is_primary_key=>false
,p_include_in_export=>true
);
wwv_flow_api.create_interactive_grid(
 p_id=>wwv_flow_api.id(14929214006872301)
,p_internal_uid=>14929214006872301
,p_is_editable=>false
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
 p_id=>wwv_flow_api.id(14934807009877722)
,p_interactive_grid_id=>wwv_flow_api.id(14929214006872301)
,p_static_id=>'149349'
,p_type=>'PRIMARY'
,p_default_view=>'GRID'
,p_rows_per_page=>100
,p_show_row_number=>false
,p_settings_area_expanded=>false
);
wwv_flow_api.create_ig_report_view(
 p_id=>wwv_flow_api.id(14935014538877722)
,p_report_id=>wwv_flow_api.id(14934807009877722)
,p_view_type=>'GRID'
,p_stretch_columns=>true
,p_srv_exclude_null_values=>false
,p_srv_only_display_columns=>true
,p_edit_mode=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(14935570708877729)
,p_view_id=>wwv_flow_api.id(14935014538877722)
,p_display_seq=>0
,p_column_id=>wwv_flow_api.id(14929333603872302)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>300
,p_sort_order=>1
,p_sort_direction=>'ASC'
,p_sort_nulls=>'LAST'
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(14936401793877733)
,p_view_id=>wwv_flow_api.id(14935014538877722)
,p_display_seq=>6
,p_column_id=>wwv_flow_api.id(14929499065872303)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(14937363792877737)
,p_view_id=>wwv_flow_api.id(14935014538877722)
,p_display_seq=>7
,p_column_id=>wwv_flow_api.id(14929507382872304)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(14938205769877740)
,p_view_id=>wwv_flow_api.id(14935014538877722)
,p_display_seq=>9
,p_column_id=>wwv_flow_api.id(14929621363872305)
,p_is_visible=>false
,p_is_frozen=>false
,p_width=>70
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(14940055040877744)
,p_view_id=>wwv_flow_api.id(14935014538877722)
,p_display_seq=>12
,p_column_id=>wwv_flow_api.id(14929897471872307)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>160
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(14955359192006429)
,p_view_id=>wwv_flow_api.id(14935014538877722)
,p_display_seq=>5
,p_column_id=>wwv_flow_api.id(14929952501872308)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(14965446688031898)
,p_view_id=>wwv_flow_api.id(14935014538877722)
,p_display_seq=>10
,p_column_id=>wwv_flow_api.id(14930051725872309)
,p_is_visible=>false
,p_is_frozen=>false
,p_width=>70
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(14974628174176864)
,p_view_id=>wwv_flow_api.id(14935014538877722)
,p_display_seq=>4
,p_column_id=>wwv_flow_api.id(14930167492872310)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>200
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(14984925118294349)
,p_view_id=>wwv_flow_api.id(14935014538877722)
,p_display_seq=>1
,p_column_id=>wwv_flow_api.id(14930252402872311)
,p_is_visible=>false
,p_is_frozen=>false
,p_break_order=>5
,p_break_is_enabled=>true
,p_break_sort_direction=>'ASC'
,p_break_sort_nulls=>'LAST'
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(16474175692840824)
,p_view_id=>wwv_flow_api.id(14935014538877722)
,p_display_seq=>3
,p_column_id=>wwv_flow_api.id(16465704569696705)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>70
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(16643570436750208)
,p_view_id=>wwv_flow_api.id(14935014538877722)
,p_display_seq=>11
,p_column_id=>wwv_flow_api.id(16466877978696716)
,p_is_visible=>false
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(21562465378800457)
,p_view_id=>wwv_flow_api.id(14935014538877722)
,p_display_seq=>2
,p_column_id=>wwv_flow_api.id(21541015139954404)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>70
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(21563306768800463)
,p_view_id=>wwv_flow_api.id(14935014538877722)
,p_display_seq=>8
,p_column_id=>wwv_flow_api.id(21541103407954405)
,p_is_visible=>false
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report(
 p_id=>wwv_flow_api.id(36527039231747011)
,p_interactive_grid_id=>wwv_flow_api.id(14929214006872301)
,p_name=>'Columns & Comments'
,p_static_id=>'215923'
,p_type=>'ALTERNATIVE'
,p_default_view=>'GRID'
,p_rows_per_page=>100
,p_show_row_number=>false
,p_settings_area_expanded=>false
);
wwv_flow_api.create_ig_report_view(
 p_id=>wwv_flow_api.id(36527246760747011)
,p_report_id=>wwv_flow_api.id(36527039231747011)
,p_view_type=>'GRID'
,p_stretch_columns=>true
,p_srv_exclude_null_values=>false
,p_srv_only_display_columns=>true
,p_edit_mode=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(36527802930747018)
,p_view_id=>wwv_flow_api.id(36527246760747011)
,p_display_seq=>0
,p_column_id=>wwv_flow_api.id(14929333603872302)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>300
,p_sort_order=>1
,p_sort_direction=>'ASC'
,p_sort_nulls=>'LAST'
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(36528634015747022)
,p_view_id=>wwv_flow_api.id(36527246760747011)
,p_display_seq=>6
,p_column_id=>wwv_flow_api.id(14929499065872303)
,p_is_visible=>false
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(36529596014747026)
,p_view_id=>wwv_flow_api.id(36527246760747011)
,p_display_seq=>7
,p_column_id=>wwv_flow_api.id(14929507382872304)
,p_is_visible=>false
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(36530437991747029)
,p_view_id=>wwv_flow_api.id(36527246760747011)
,p_display_seq=>9
,p_column_id=>wwv_flow_api.id(14929621363872305)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>70
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(36532287262747033)
,p_view_id=>wwv_flow_api.id(36527246760747011)
,p_display_seq=>12
,p_column_id=>wwv_flow_api.id(14929897471872307)
,p_is_visible=>false
,p_is_frozen=>false
,p_width=>160
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(36547591413875718)
,p_view_id=>wwv_flow_api.id(36527246760747011)
,p_display_seq=>5
,p_column_id=>wwv_flow_api.id(14929952501872308)
,p_is_visible=>false
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(36557678909901187)
,p_view_id=>wwv_flow_api.id(36527246760747011)
,p_display_seq=>10
,p_column_id=>wwv_flow_api.id(14930051725872309)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>70
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(36566860396046153)
,p_view_id=>wwv_flow_api.id(36527246760747011)
,p_display_seq=>4
,p_column_id=>wwv_flow_api.id(14930167492872310)
,p_is_visible=>false
,p_is_frozen=>false
,p_width=>200
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(36577157340163638)
,p_view_id=>wwv_flow_api.id(36527246760747011)
,p_display_seq=>1
,p_column_id=>wwv_flow_api.id(14930252402872311)
,p_is_visible=>false
,p_is_frozen=>false
,p_break_order=>5
,p_break_is_enabled=>true
,p_break_sort_direction=>'ASC'
,p_break_sort_nulls=>'LAST'
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(38066407914710113)
,p_view_id=>wwv_flow_api.id(36527246760747011)
,p_display_seq=>3
,p_column_id=>wwv_flow_api.id(16465704569696705)
,p_is_visible=>false
,p_is_frozen=>false
,p_width=>70
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(38235802658619497)
,p_view_id=>wwv_flow_api.id(36527246760747011)
,p_display_seq=>11
,p_column_id=>wwv_flow_api.id(16466877978696716)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(43154697600669746)
,p_view_id=>wwv_flow_api.id(36527246760747011)
,p_display_seq=>2
,p_column_id=>wwv_flow_api.id(21541015139954404)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>70
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(43155538990669752)
,p_view_id=>wwv_flow_api.id(36527246760747011)
,p_display_seq=>8
,p_column_id=>wwv_flow_api.id(21541103407954405)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(21547186191979378)
,p_button_sequence=>50
,p_button_plug_id=>wwv_flow_api.id(14220162747378949)
,p_button_name=>'SEARCH'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(9145249029569999)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Search'
,p_button_position=>'BODY'
,p_button_css_classes=>'SEARCH_FIELDS'
,p_grid_new_row=>'N'
,p_grid_new_column=>'Y'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(15022487988059629)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(14220162747378949)
,p_button_name=>'REFRESH'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(9144574670569995)
,p_button_image_alt=>'Refresh'
,p_button_position=>'RIGHT_OF_TITLE'
,p_button_redirect_url=>'f?p=&APP_ID.:955:&SESSION.::&DEBUG.:955::'
,p_icon_css_classes=>'fa-refresh'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(21546578024971053)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(14220162747378949)
,p_button_name=>'SHOW_SEARCH'
,p_button_static_id=>'BUTTON_SHOW_SEARCH'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(9144574670569995)
,p_button_image_alt=>'Search'
,p_button_position=>'RIGHT_OF_TITLE'
,p_button_execute_validations=>'N'
,p_warn_on_unsaved_changes=>null
,p_icon_css_classes=>'fa-search'
,p_button_cattributes=>'style="margin-right: 0;"'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(21546844300972203)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_api.id(14220162747378949)
,p_button_name=>'CLOSE_SEARCH'
,p_button_static_id=>'BUTTON_CLOSE_SEARCH'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(9144574670569995)
,p_button_image_alt=>'Close Search'
,p_button_position=>'RIGHT_OF_TITLE'
,p_button_execute_validations=>'N'
,p_warn_on_unsaved_changes=>null
,p_icon_css_classes=>'fa-times'
,p_button_cattributes=>'style="margin-right: 0; display: none;"'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(14930403398872313)
,p_button_sequence=>40
,p_button_plug_id=>wwv_flow_api.id(14220162747378949)
,p_button_name=>'REBUILD'
,p_button_static_id=>'BUTTON_REBUILD'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(9145249029569999)
,p_button_image_alt=>'Rebuild'
,p_button_position=>'RIGHT_OF_TITLE'
,p_button_redirect_url=>'f?p=&APP_ID.:955:&SESSION.::&DEBUG.:955:P955_REBUILD:Y'
,p_button_cattributes=>'title="Rebuild USER_SOURCE_VIEWS table"'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(14930610862872315)
,p_name=>'P955_REBUILD'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(14220162747378949)
,p_use_cache_before_default=>'NO'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(14931154674872320)
,p_name=>'P955_VIEW_NAME'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(14220162747378949)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(21457026534924150)
,p_name=>'P955_SEARCH_VIEWS'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(14220162747378949)
,p_prompt=>'View Like'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_grid_row_css_classes=>'HIDDEN'
,p_colspan=>2
,p_field_template=>wwv_flow_api.id(9142775823569991)
,p_item_css_classes=>'SEARCH_FIELDS'
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(21540738826954401)
,p_name=>'P955_SEARCH_SOURCE'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(14220162747378949)
,p_prompt=>'Source Contains'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_colspan=>3
,p_field_template=>wwv_flow_api.id(9142775823569991)
,p_item_css_classes=>'SEARCH_FIELDS'
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(21540881630954402)
,p_name=>'P955_SEARCH_COLUMNS'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(14220162747378949)
,p_prompt=>'Column Like'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_colspan=>2
,p_field_template=>wwv_flow_api.id(9142775823569991)
,p_item_css_classes=>'SEARCH_FIELDS'
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(21540977667954403)
,p_name=>'P955_SHOW_SEARCH'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(14220162747378949)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(21550971914032471)
,p_name=>'CLOSE_SEARCH'
,p_event_sequence=>10
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(21546844300972203)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(21551386209032476)
,p_event_id=>wwv_flow_api.id(21550971914032471)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'$(''.SEARCH_FIELDS'').hide();',
'$(''#BUTTON_CLOSE_SEARCH'').hide();',
'$(''#BUTTON_SHOW_SEARCH'').show().focus();',
'$(''#BUTTON_REBUILD'').show();',
''))
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(21551749445033713)
,p_name=>'SHOW_SEARCH'
,p_event_sequence=>20
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(21546578024971053)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(21552635724033714)
,p_event_id=>wwv_flow_api.id(21551749445033713)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'$(''.t-HeroRegion-col.t-HeroRegion-col--content .HIDDEN'').removeClass(''HIDDEN'');',
'//',
'$(''.SEARCH_FIELDS'').show();',
'$(''#BUTTON_REBUILD'').hide();',
'$(''#BUTTON_SHOW_SEARCH'').hide();',
'$(''#BUTTON_CLOSE_SEARCH'').show().focus();',
''))
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(21552181929033714)
,p_event_id=>wwv_flow_api.id(21551749445033713)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'$(''.t-HeroRegion-col.t-HeroRegion-col--content .HIDDEN'').removeClass(''HIDDEN'');',
'//',
'$(''.SEARCH_FIELDS'').show();',
'$(''#BUTTON_REBUILD'').hide();',
'$(''#BUTTON_SHOW_SEARCH'').hide();',
'$(''#BUTTON_CLOSE_SEARCH'').show().focus();',
''))
,p_server_condition_type=>'ITEM_IS_NOT_NULL'
,p_server_condition_expr1=>'P955_SHOW_SEARCH'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(14930334361872312)
,p_process_sequence=>10
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'REFRESH_VIEWS_SOURCE'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'app_actions.refresh_user_source_views();',
''))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when=>'P955_REBUILD'
,p_process_when_type=>'ITEM_IS_NOT_NULL'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(21558331173182171)
,p_process_sequence=>20
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'INIT_DEFAULTS'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
':P955_SHOW_SEARCH               := NULL;',
'--',
'IF (:P955_SEARCH_VIEWS          IS NOT NULL',
'    OR :P955_SEARCH_COLUMNS     IS NOT NULL',
'    OR :P955_SEARCH_SOURCE      IS NOT NULL',
') THEN',
'    :P955_VIEW_NAME             := NULL;',
'    :P955_SHOW_SEARCH           := ''Y'';',
'END IF;',
''))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.component_end;
end;
/
