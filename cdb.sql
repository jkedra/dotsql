SET LINES 80
COL property_name FORMAT A30 HEADING name
COL property_value FORMAT A30 HEADING value
col con_name FORMAT A8
col con_id FORMAT A8
col db_name FORMAT A8

PROMPT v$containers
COLUMN NAME FORMAT A8
SELECT NAME, CON_ID, DBID, CON_UID, GUID FROM V$CONTAINERS ORDER BY CON_ID;

PROMPT DBA_PDBS
COLUMN PDB_NAME FORMAT A15
SELECT PDB_ID, PDB_NAME, STATUS FROM DBA_PDBS ORDER BY PDB_ID;

PROMPT IS CDB
SELECT cdb FROM V$DATABASE;

select sys_context('USERENV','CON_NAME') con_name,
            sys_context('USERENV','CON_ID') con_id,
            sys_context('USERENV','DB_NAME') db_name from DUAL;

SELECT property_name, property_value
FROM cdb_properties;

REM /u960/sabredba/firecall/deploy_appdba.sql
REM /u960/sabredba/firecall/appdba_util.sql 
