SET VERIFY OFF
COL granted_role FORMAT A30
COL def FORMAT A4
SELECT granted_role,admin_option adm, default_role def
FROM dba_role_privs WHERE grantee=UPPER('&1')
/
SET VERIFY ON
