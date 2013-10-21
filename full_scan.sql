SET PAGESIZE 80
SET LINESIZE 140
COL sql_fulltext FORMAT a80
COL strcost HEADING "COST|CPU|IO" FORMAT A12
COL tbl HEADING "TABLE|SQL_ID" FORMAT a20
SET LONG 4000

SELECT * FROM (
select object_name||CHR(10)||s.sql_id tbl, cost||CHR(10)||cpu_cost||CHR(10)||io_cost strcost,
       sql_fulltext from dba_hist_sql_plan h, v$sql s
where operation='TABLE ACCESS' AND options='FULL' and object_owner='TASDBA'
AND h.sql_id=s.sql_id
order by cost desc
)
WHERE ROWNUM <10;
