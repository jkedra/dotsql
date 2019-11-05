SET LINES 120
PROMPT LINES 120
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
COL last_start FORMAT A19
SELECT ROWNUM l,owner,job_name,DECODE(state, 'SCHEDULED', 'SCH',
                                             'DISABLED', 'DIS',
                                      state) STA,
               TO_CHAR(last_start_date, 'DDMMYY HH24:MI TZR') last_start,
				CAST(last_RUN_DURATION
					AS INTERVAL DAY(1) TO SECOND(0)) last_run_dur,
               TO_CHAR(next_run_date, 'HH24:MI') nxtst
       FROM all_scheduler_jobs
         WHERE owner IN ('AT', 'LPS', 'LPS_ACTIVE','COMM');


PROMPT ====== DBA_JOBS =======
PROMPT F=FAILURES
PROMPT
    COL priv_user FORMAT A15
    COL schema_user FORMAT A15
    COL what FORMAT A35
    COL F FORMAT 9
    SELECT rownum l, priv_user, schema_user,
           broken brk,failures F,what, last_date
        FROM dba_jobs;

PROMPT
PROMPT ======================