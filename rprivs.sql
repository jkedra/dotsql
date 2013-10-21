SET VERIFY OFF
SELECT * FROM ROLE_TAB_PRIVS WHERE role='&1';
SELECT * FROM role_role_privs WHERE role='&1';
SELECT * FROM role_sys_privs WHERE role='&1';

SELECT * FROM dba_role_privs WHERE granted_role='&1';

