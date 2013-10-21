
select privilege,admin_option adm from dba_sys_privs where grantee=UPPER('&1')
/
