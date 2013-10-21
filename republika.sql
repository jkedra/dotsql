SET VERIFY OFF;
SET FEEDBACK OFF;
SET PAGESIZE 0; 
alter session set sort_area_size=268435456;
SET ECHO ON;

alter table &1 move tablespace repdat;

SET ECHO OFF;
SPOOL /tmp/out.sql

SELECT 'SET ECHO ON;' FROM DUAL;
select 'ALTER INDEX '||index_name||' REBUILD TABLESPACE REPIDX;'
 from dba_indexes where owner='REPUBLIKA' and table_name=upper('&1')
/
SPOOL OFF;

@/tmp/out.sql
analyze table &1 estimate statistics sample 10 percent;

SET ECHO OFF;
PROMPT 'ANALYZE TABLE &1 COMPUTE STATISTICS;'
PROMPT
PROMPT
