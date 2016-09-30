set lines 155
col execs for 999,999,999
col max_etime for 999,999,999.9
col avg_etime for 999,999.999
col avg_lio for 999,999,999.9
col begin_interval_time for a30
col node for 99999
BREAK ON plan_hash_value ON startup_time SKIP 1

SELECT sql_id, plan_hash_value,
	SUM(execs) execs,
        MAX(etime) max_etime,
        SUM(etime)/SUM(execs) avg_etime,
        SUM(lio)/SUM(execs) avg_lio
FROM (
	SELECT 	ss.snap_id,
		ss.instance_number node,
		begin_interval_time,
		sql_id, plan_hash_value,
		NVL(executions_delta,0) execs,
		elapsed_time_delta/1000000 etime,
		(elapsed_time_delta/decode(NVL(executions_delta,0),0,1,executions_delta))/1000000 avg_etime,
		buffer_gets_delta lio,
		(buffer_gets_delta/decode(NVL(buffer_gets_delta,0),0,1,executions_delta)) avg_lio
	FROM dba_hist_sqlstat S, dba_hist_snapshot SS
	WHERE sql_id = nvl('&sql_id','4dqs2k5tynk61')
		AND ss.snap_id = S.snap_id
		AND ss.instance_number = S.instance_number 
		AND executions_delta > 0
)
GROUP BY sql_id, plan_hash_value
ORDER BY 5
/

