COL privilege FORMAT A30

SELECT privilege,admin_option adm
FROM dba_sys_privs WHERE grantee=UPPER('&1')
ORDER BY privilege ASC
/
