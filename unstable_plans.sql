----------------------------------------------------------------------------------------
--
-- File name:   unstable_plans.sql
--
-- Purpose:     Attempts to find SQL statements with plan instability.
--
-- Author:      Kerry Osborne
--
-- Usage:       This scripts prompts for two values, both of which can be left blank.
--
--              min_stddev: the minimum "normalized" standard deviation between plans 
--                          (the default is 2)
--
--              min_etime:  only include statements that have an avg. etime > this value
--                          (the default is .1 second)
--
-- See http://kerryosborne.oracle-guy.com/2008/10/unstable-plans/ for more info.
---------------------------------------------------------------------------------------

set lines 155
col execs for 999,999,999
col min_etime HEADING "min_etime|[seconds]" for 999,999.99
col max_etime HEADING "max_etime|[seconds]" for 999,999.99
col avg_etime HEADING "avg_etime|[seconds]" for 999,999.999
col avg_lio for 999,999,999.9
col norm_stddev HEADING "norm_stddev|etime" for 999,999.9999 
col begin_interval_time for a30
COL node FORMAT 9 HEADING #
COL snap_id FORMAT 999999
break on plan_hash_value on startup_time skip 1

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

-- DBA_HIST_SNAPSHOT
-- (11) https://docs.oracle.com/cloud/latest/db112/REFRN/statviews_4045.htm#REFRN23442


SELECT * FROM (
    SELECT sql_id,
           SUM(execs) execs,
           MIN(avg_etime) min_etime,
           MAX(avg_etime) max_etime,
           stddev_etime/MIN(avg_etime) norm_stddev
    FROM (
        SELECT sql_id, plan_hash_value, execs, avg_etime,
        STDDEV(avg_etime) OVER (partition by sql_id) stddev_etime
        FROM (
            SELECT sql_id, plan_hash_value,
                   SUM(NVL(executions_delta,0)) execs,
                   (SUM(elapsed_time_delta)/DECODE( SUM(NVL(executions_delta,0)),
                                                     0, 1,
                                                    SUM(executions_delta))/1000000) avg_etime
            -- sum((buffer_gets_delta/decode(nvl(buffer_gets_delta,0),0,1,executions_delta))) avg_lio
            FROM dba_hist_sqlstat S, dba_hist_snapshot SS
                WHERE ss.snap_id = S.snap_id
                  AND ss.instance_number = S.instance_number
                  AND executions_delta > 0
                GROUP BY sql_id, plan_hash_value
        )
    )
    GROUP BY sql_id, stddev_etime
)
WHERE norm_stddev > NVL(TO_NUMBER('&min_stddev'),2)
AND max_etime > nvl(to_number('&min_maxetime'),.1)
--ORDER BY norm_stddev
ORDER BY norm_stddev*execs
/

