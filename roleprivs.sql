SET LINES 100
SET VERIFY OFF
COL grantee FORMAT A30
COL granted_role FORMAT A30

COL owner FORMAT A15
COL privilege FORMAT A30
COL table_name FORMAT A30

PROMPT dba_role_privs
SELECT granted_role FROM dba_role_privs WHERE grantee='&&role';
PROMPT dba_sys_privs
SELECT privilege FROM dba_sys_privs WHERE grantee='&&role';
PROMPT dba_tab_privs
SELECT owner,table_name,privilege
    FROM dba_tab_privs WHERE grantee='&&role'
    ORDER BY 1,2,3;

SET VERIFY ON
