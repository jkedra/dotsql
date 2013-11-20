set lines 130
set head off
spool  xplan9.lst
alter session set cursor_sharing=EXACT;
select plan_table_output from table(dbms_xplan.display('PLAN_TABLE',null,'ALL'));
spool off

