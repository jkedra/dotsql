-- vim:ts=4
-- 11g up version
--
set verify off
set pagesize 999
SET LINESIZE 160
SET NUMWIDTH 3
SET LONG 32000

col username format a13
col prog format a22
col sql_text format a80 word_wrapped
col sid format 999
col child_number format 99999 heading CHILD
col ocategory format a10
col avg_etime format 9,999,999.99
col etime format 9,999,999.99


COL sqlid HEADING "sql_id|plan_hash" FORMAT A13

SELECT /* sq9mcp */ sql_id||'  '||plan_hash_value sqlid, child_number, inst_id ins,
    executions excs, elapsed_time/1000000 etime,
    (elapsed_time/1000000)/decode(nvl(executions,0),0,1,executions) avg_etime,
    u.username, sql_fulltext
FROM gv$sql s, dba_users u
WHERE upper(sql_fulltext) LIKE upper(nvl(q'{%&sql_text%}',sql_fulltext))
    AND NOT
    (
        sql_text LIKE '%sq9mcp%' OR
        sql_text LIKE 'EXPLAIN PLAN %' OR
        sql_text LIKE '%v$sql s, dba_users u%'
    )
    AND sql_id LIKE nvl('&sql_id',sql_id)
    AND u.user_id = s.parsing_user_id
/



--SELECT /* sq9mcp */ sql_id, child_number, plan_hash_value plan_hash,
--	executions execs, elapsed_time/1000000 etime,
--	(elapsed_time/1000000)/decode(nvl(executions,0),0,1,executions) avg_etime,
--	u.username, sql_fulltext
--FROM v$sql s, dba_users u
--WHERE UPPER(sql_fulltext) LIKE UPPER(NVL('%&sql_text%',sql_fulltext))
--AND sql_text NOT LIKE '%from v$sql where sql_text like nvl(%'
--AND sql_id LIKE nvl('&sql_id',sql_id)
--AND u.user_id = s.parsing_user_id
--/

