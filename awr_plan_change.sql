set lines 155
col execs for 999,999,999
col avg_etime for 999,999.999
col avg_lio for 999,999,999.9
col begin_interval_time for a30
col node for 99999
col plan_hash_value format 9999999999

-- DBA_HIST_SQLSTAT
-- http://docs.oracle.com/cd/E18283_01/server.112/e17110/statviews_4051.htm
--
-- ELAPSED_TIME_TOTAL:
--  Cumulative value of elapsed time (in microseconds)
--  used by this cursor for parsing/executing/fetching
--
-- ELAPSED_TIME_DELTA:
--  Delta value of elapsed time (in microseconds)
--  used by this cursor for parsing/executing/fetching
--
-- EXECUTIONS_TOTAL:
--  Cumulative number of executions that took place on this object
--  since it was brought into the library cache.
--
-- EXECUTIONS_DELTA:
--  Delta number of executions that took place on this object
--  since it was brought into the library cache

COL snap_id FORMAT 999999
COL execs FORMAT 99999
COL node FORMAT 9 HEADING #

PROMPT avg_etime in seconds
ACCEPT vdays CHAR DEFAULT 14 PROMPT "days [14]: "

BREAK ON plan_hash_value ON startup_time skip 1

SELECT	ss.snap_id,
	ss.instance_number node,
	TO_CHAR(begin_interval_time, 'DD.MM.YYYY HH24:MI') begin_time,
	sql_id,
	plan_hash_value,
	NVL(executions_delta,0) execs,
    (elapsed_time_delta /
         DECODE( NVL(executions_delta,0),
                 0,1,executions_delta ) )/1000000 avg_etime,
    (buffer_gets_delta/
         DECODE(NVL(buffer_gets_delta,0),
                 0,1,executions_delta)) avg_lio
  FROM dba_hist_sqlstat S, dba_hist_snapshot SS
	WHERE sql_id = NVL('&sql_id','4dqs2k5tynk61')
	  AND ss.snap_id = S.snap_id
	  AND ss.instance_number = S.instance_number
	  AND executions_delta > 0
      AND begin_interval_time > SYSDATE-&vdays
ORDER BY 1, 2, 3
/

