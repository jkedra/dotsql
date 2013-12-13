set verify off
set pages 9999
set lines 200
PROMPT Additional flags
PROMPT LAST

select * from table(dbms_xplan.display_cursor('&sql_id','&child_no','LAST'))
