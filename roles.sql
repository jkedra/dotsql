SET VERIFY OFF
SELECT granted_role,admin_option adm, default_role def
FROM dba_role_privs WHERE grantee=UPPER('&1')
/
SET VERIFY ON
