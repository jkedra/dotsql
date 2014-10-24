set verify off
set pages 9999
set lines 250
PROMPT Additional flags
PROMPT ALL ALLSTATS +peeked_bind
PROMPT Spooling to /tmp/plan.txt

SPOOL /tmp/plan.txt
select * from table(dbms_xplan.display_cursor('&sql_id','&child_no','ALL ALLSTATS +peeked_binds -MEMSTATS'))

REM SELECT * from table(dbms_xplan.display_cursor('&sql_id','&child_no','ADVANCED ALLSTATS ALL -memstats'))

/
SPOOL OFF

