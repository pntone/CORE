prompt --application/shared_components/security/authorizations/is_administrator
begin
--   Manifest
--     SECURITY SCHEME: IS_ADMINISTRATOR
--   Manifest End
wwv_flow_api.component_begin (
 p_version_yyyy_mm_dd=>'2021.04.15'
,p_release=>'21.1.7'
,p_default_workspace_id=>9014660246496943
,p_default_application_id=>770
,p_default_id_offset=>0
,p_default_owner=>'CORE'
);
wwv_flow_api.create_security_scheme(
 p_id=>wwv_flow_api.id(9823062898204869)
,p_name=>'IS_ADMINISTRATOR'
,p_scheme_type=>'NATIVE_FUNCTION_BODY'
,p_attribute_01=>'RETURN a770.is_administrator() = ''Y'';'
,p_error_message=>'ACCESS_DENIED'
,p_caching=>'BY_USER_BY_PAGE_VIEW'
);
wwv_flow_api.component_end;
end;
/
