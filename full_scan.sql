SET PAGESIZE 80
SET LINESIZE 140
COL sql_fulltext FORMAT a80
COL strcost HEADING "COST|CPU|IO" FORMAT A12
COL tbl HEADING "TABLE|OWNER|SQL_ID|TIMESTAMP" FORMAT a20
SET LONG 4000

SELECT object_name||CHR(10)||object_owner||CHR(10)||s.sql_id||CHR(10)||timestamp tbl,
       cost||CHR(10)||cpu_cost||CHR(10)||io_cost strcost,
       sql_fulltext
FROM dba_hist_sql_plan h, v$sql s
WHERE operation='TABLE ACCESS'
  AND options='FULL'
  AND (object_owner LIKE 'LPS%' OR object_owner IN ('AT', 'ACTVIVE_MQ', 'COMM'))
  AND h.sql_id=s.sql_id
ORDER BY cost DESC
FETCH NEXT 10 ROWS ONLY;
