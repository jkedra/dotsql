set verify off
set pagesize 999
set LINES 160
-- 10K
SET LONG 10000
col username format a13
col prog format a22


COL sql_text FORMAT A120 WORD_WRAPPED

col sql_full format a130 word_wrapped
col sql_fulltext format A100 word_wrapped
col sid format 999
col child_number format 99999 heading CHILD
col ocategory format a10
col avg_etime format 9,999,999.99
col etime format 9,999,999.99


--select sql_id, child_number, plan_hash_value plan_hash, executions execs, elapsed_time/1000000 etime,
--(elapsed_time/1000000)/decode(nvl(executions,0),0,1,executions) avg_etime, u.username,
--sql_text
--from v$sql s, dba_users u
--where upper(sql_text) like upper(nvl('%&sql_text%',sql_text))
--and sql_text not like '%from v$sql where sql_text like nvl(%'
--and sql_id like nvl('&sql_id',sql_id)
--and u.user_id = s.parsing_user_id

SELECT sql_text FROM dba_hist_sqltext
WHERE sql_id='&sql_id'
/

