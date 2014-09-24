set verify off
set pages 9999
set lines 200
PROMPT You have to issue SET SERVEROUTPUT OFF prior runing the query.
PROMPT Otherwise the last statement you will have run will be
PROMPT the (hidden) call to dbms_output that follows your execution
PROMPT of any other statement – so you won’t get the plan and statistics.
PROMPT
PROMPT Additional flags
PROMPT ALL ALLSTATS LAST

SELECT * from table(dbms_xplan.display_cursor(NULL, NULL,'ALL ALLSTATS LAST'));

