
SET VERIFY OFF
COL GRANTEE FORMAT A30
COL GRANTED_ROLE FORMAT A30
COL PRIVILEGE FORMAT A30

SELECT * FROM dba_sys_privs WHERE GRANTEE='&&GRANTEE';

SELECT * FROM dba_role_privs WHERE GRANTEE='&&GRANTEE';