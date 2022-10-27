prompt --application/shared_components/globalization/messages
begin
--   Manifest
--     MESSAGES: 770
--   Manifest End
wwv_flow_imp.component_begin (
 p_version_yyyy_mm_dd=>'2022.04.12'
,p_release=>'22.1.4'
,p_default_workspace_id=>9014660246496943
,p_default_application_id=>770
,p_default_id_offset=>0
,p_default_owner=>'CORE'
);
null;
wwv_flow_imp.component_end;
end;
/
begin
wwv_flow_imp.component_begin (
 p_version_yyyy_mm_dd=>'2022.04.12'
,p_release=>'22.1.4'
,p_default_workspace_id=>9014660246496943
,p_default_application_id=>770
,p_default_id_offset=>0
,p_default_owner=>'CORE'
);
wwv_flow_imp_shared.create_message(
 p_id=>wwv_flow_imp.id(25002332653328923)
,p_name=>'APEX.IG.CHANGES_SAVED'
,p_message_language=>'cs'
,p_message_text=>unistr('Ulo\017Eeno [CZ]')
,p_is_js_message=>true
);
wwv_flow_imp_shared.create_message(
 p_id=>wwv_flow_imp.id(26178820728351588)
,p_name=>'APEX.IG.CHANGES_SAVED'
,p_message_text=>'Saved [EN]'
,p_is_js_message=>true
);
wwv_flow_imp.component_end;
end;
/
