prompt --application/shared_components/logic/application_items/t_page_name
begin
--   Manifest
--     APPLICATION ITEM: T_PAGE_NAME
--   Manifest End
wwv_flow_api.component_begin (
 p_version_yyyy_mm_dd=>'2021.04.15'
,p_release=>'21.1.7'
,p_default_workspace_id=>9014660246496943
,p_default_application_id=>770
,p_default_id_offset=>0
,p_default_owner=>'CORE'
);
wwv_flow_api.create_flow_item(
 p_id=>wwv_flow_api.id(24852157682748486)
,p_name=>'T_PAGE_NAME'
,p_protection_level=>'I'
);
wwv_flow_api.component_end;
end;
/
