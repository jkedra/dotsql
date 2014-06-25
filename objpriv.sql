SET LINES 160
COL grantee    FORMAT A20
COL table_name FORMAT A30

SELECT * FROM dba_tab_privs
WHERE grantee='&grantee' and owner='&owner'
ORDER BY owner,table_name,privilege;

