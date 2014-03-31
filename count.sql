SET ECHO OFF FEEDBACK OFF VERIFY OFF TIMING OFF HEAD OFF
SET TERMOUT OFF
COL p1 NEW_VALUE dbname
SELECT global_name p1 FROM global_name;
COL p1 CLEAR

SPOOL /tmp/&dbname.-cnt.sql

PROMPT SPOOL &dbname.-count.txt
SELECT 'SELECT count(*) cnt FROM '||owner||'.'||table_name||';'
FROM dba_tables WHERE owner='TASDBA'
ORDER BY table_name;
PROMPT SPOOL OFF

SPOOL OFF
@@/tmp/&dbname.-cnt.sql

SET TERMOUT ON FEEDBACK ON HEAD ON
PROMPT counts written to file &dbname.-count.txt
:x

