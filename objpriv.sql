SET LINES 160
COL grantee    FORMAT A20
COL table_name FORMAT A30

SELECT * FROM dba_tab_privs
WHERE grantee='TASGEN' and owner='TASDBA'
ORDER BY owner,table_name,privilege;

