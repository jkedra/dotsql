SET LINES 120
PROMPT LINES 120

PROMPT https://docs.oracle.com/cd/B13866_04/webconf.904/b10877/timezone.htm
ACCEPT vtz CHAR DEFAULT 'Europe/Warsaw' PROMPT "timezone  [ Europe/Warsaw ]: "
--ACCEPT days NUMBER DEFAULT 1            PROMPT "days to look back     [ 1 ]: "


SELECT
  TO_CHAR(log_date AT TIME ZONE '&&vtz',
          'YYYY-MM-DD HH24:MI') log_date,


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
               TO_CHAR(last_start_date AT TIME ZONE '&&vtz',
                       'DDMMYY HH24:MI TZR') last_start,
				CAST(last_RUN_DURATION
					AS INTERVAL DAY(1) TO SECOND(0)) last_run_dur,
               TO_CHAR(next_run_date AT TIME ZONE '&&vtz',
                       'HH24:MI') nxtst
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
