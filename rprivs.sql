SET VERIFY OFF
SET LINES 120
COL         role FORMAT A12
COL granted_role FORMAT A12
COL column_name  FORMAT A15
COL table_name   FORMAT A30
COL grantee      FORMAT A20

SELECT * FROM ROLE_TAB_PRIVS WHERE role='&1';
SELECT * FROM role_role_privs WHERE role='&1';
SELECT * FROM role_sys_privs WHERE role='&1';

SELECT * FROM dba_role_privs WHERE granted_role='&1';

