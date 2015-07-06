set verify off
set pages 9999
set lines 200
PROMPT Additional flags: none
--PROMPT LAST

select * from table(dbms_xplan.display_cursor())
/
