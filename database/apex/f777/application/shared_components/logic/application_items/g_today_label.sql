prompt --application/shared_components/logic/application_items/g_today_label
begin
--   Manifest
--     APPLICATION ITEM: G_TODAY_LABEL
--   Manifest End
wwv_flow_imp.component_begin (
 p_version_yyyy_mm_dd=>'2022.04.12'
,p_release=>'22.1.2'
,p_default_workspace_id=>9014660246496943
,p_default_application_id=>777
,p_default_id_offset=>26909373241738856
,p_default_owner=>'CORE'
);
wwv_flow_imp_shared.create_flow_item(
 p_id=>wwv_flow_imp.id(37528621948788698)
,p_name=>'G_TODAY_LABEL'
,p_scope=>'GLOBAL'
,p_protection_level=>'I'
);
wwv_flow_imp.component_end;
end;
/
