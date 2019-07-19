PROMPT
PROMPT === ALL_SCHEDULER_JOBS ======
PROMPT

COL job_name FORMAT A25
COL l FORMAT 99

PROMPT COLUMN STATE(STA)
PROMPT SCH = SCHEDULED
PROMPT DIS = DISABLED
PROMPT
PROMPT NXTST = NEXT START

COL STA FORMAT A3
COL last_RUN_DUR FORMAT A11
SELECT ROWNUM l,owner,job_name,DECODE(state, 'SCHEDULED', 'SCH',
                                             'DISABLED', 'DIS',
                                      state) STA,
               TO_CHAR(last_start_date, 'DDMMYY HH24:MI') last_start,
				CAST(last_RUN_DURATION
					AS INTERVAL DAY(1) TO SECOND(0)) last_run_dur,
               TO_CHAR(next_run_date, 'HH24:MI') nxtst
       FROM all_scheduler_jobs
         WHERE owner IN ('AT', 'LPS', 'LPS_ACTIVE','COMM');


PROMPT ====== DBA_JOBS =======
PROMPT
    COL priv_user FORMAT A15
    COL schema_user FORMAT A15
    COL what FORMAT A35
    COL fail FORMAT 99
    SELECT rownum l, priv_user, schema_user,
           broken brk,failures fail,what
        FROM dba_jobs;

PROMPT
PROMPT ======================
