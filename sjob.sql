SET LINES 120
SET VERIFY OFF

COL VALUE FORMAT A60
COL PARAMETER FORMAT A20

SELECT * FROM (
    SELECT owner, job_creator, job_name, job_action, job_type,
           schedule_type,
           TO_CHAR(start_date, 'DD.MM.YYYY HH24:MI TZR') start_date,
           repeat_interval,
           TO_CHAR(last_start_date, 'DD.MM.YYYY HH24:MI TZR') last_start_date,
           TO_CHAR(next_run_date, 'DD.MM.YYYY HH24:MI TZR') next_run_date,
           TO_CHAR(CAST(last_RUN_DURATION
                    AS INTERVAL DAY(1) TO SECOND(0))) last_run_duration,
           enabled, state, auto_drop, store_output, 
           TO_CHAR(run_count) run_count, TO_CHAR(max_failures) max_failures 
       FROM all_scheduler_jobs
         WHERE job_name='&1')
UNPIVOT (value FOR parameter
            IN (owner, job_creator, job_name, job_action, job_type,
                schedule_type,
                start_date,
                repeat_interval,
                last_start_date,
                next_run_date,
                last_run_duration,
                enabled, state, auto_drop, store_output, 
                run_count, max_failures ));

COL log_date FORMAT A23
COL actl_start FORMAT A10
COL status FORMAT A3
COL run_duration FORMAT A12
COL i FORMAT 99
COL output FORMAT A30 WRAPPED

SELECT TO_CHAR(log_date, 'DD.MM.YYYY HH24:MI TZR') log_date,
       TO_CHAR(actual_start_date, 'DDMM HH24:MI') actl_start,
       DECODE(status, 'SUCCEEDED', 'SUC', SUBSTR(1,3,status)) status,
       CAST(RUN_DURATION
                    AS INTERVAL DAY(1) TO SECOND(0)) run_duration,
       instance_id i,
       SUBSTR(output, -120, 120) output
--,output
FROM ALL_SCHEDULER_JOB_RUN_DETAILS
WHERE job_name='&1'
ORDER BY log_id DESC
FETCH NEXT 7 ROWS ONLY; 

