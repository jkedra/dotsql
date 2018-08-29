SET ECHO OFF FEEDBACK OFF VERIFY OFF TIMING OFF HEAD OFF
SET TERMOUT OFF
COL p1 NEW_VALUE dbname
SELECT global_name p1 FROM global_name;
COL p1 CLEAR

SET ECHO OFF FEEDBACK ON VERIFY OFF TIMING OFF HEAD ON

SET pages 999
COL count FORMAT 999,999,999
COL table_name FORMAT A30
COL owner FORMAT A16

SPOOL &dbname.-count.txt
SET TIMING ON
SELECT
   owner, table_name,
   TO_NUMBER(
   EXTRACTVALUE(
      XMLTYPE(
         DBMS_XMLGEN.GETXML('SELECT COUNT(*) c FROM '||owner||'.'||table_name))
    ,'/ROWSET/ROW/C')) count
FROM all_tables
WHERE OWNER IN ('AT', 'ATGUEST', 
                'ACTIVE_MQ',
                'COMM',
                'LPS', 'LPS_ACTIVE', 'LPS_GUEST', 'LPS_SECURITY',
                'LPS_STATIC', 'LPS_STATS')
ORDER BY owner, table_name;
SET TIMING OFF

SPOOL OFF
