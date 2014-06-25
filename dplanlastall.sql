set verify off
set pages 9999
set lines 200
PROMPT Additional flags
PROMPT ALL ALLSTATS LAST

SELECT * from table(dbms_xplan.display_cursor(NULL, NULL,'ALL ALLSTATS LAST'));

