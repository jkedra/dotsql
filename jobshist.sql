

COL log_date FORMAT A16
COL req_start_date FORMAT A9 HEADING 'requested|start'
COL actual_start_date FORMAT A5 HEADING 'actual|start'

COL owner        FORMAT A10
COL job_name     FORMAT A25
COL status       FORMAT A3 HEADING 'sta|tus'
COL duration     FORMAT A8 HEADING 'duration|HH:MM:SS'

PROMPT https://docs.oracle.com/cd/B13866_04/webconf.904/b10877/timezone.htm
ACCEPT vtz CHAR DEFAULT 'Europe/Warsaw' PROMPT "timezone  [ Europe/Warsaw ]: "
ACCEPT days NUMBER DEFAULT 1            PROMPT "days to look back     [ 1 ]: "

SET VERIFY OFF
SET PAGES 24

SELECT
  TO_CHAR(log_date AT TIME ZONE '&&vtz',
          'YYYY-MM-DD HH24:MI') log_date,
  owner, job_name,
  SUBSTR(status, 1, 3) status,
  TO_CHAR(req_start_date AT TIME ZONE '&&vtz',
          '-DD HH24:MI') req_start_date,
  TO_CHAR(actual_start_date AT TIME ZONE '&&vtz',
          'HH24:MI') actual_start_date,
  LPAD(EXTRACT(DAY FROM run_duration)*24 +
          EXTRACT(HOUR FROM run_duration), 2, '0') ||':'||
  LPAD(EXTRACT(MINUTE FROM run_duration), 2, '0') ||':'||
  LPAD(ROUND(EXTRACT(SECOND FROM run_duration)), 2, '0') duration
FROM DBA_SCHEDULER_JOB_RUN_DETAILS
  WHERE log_date > SYSDATE - &&days
ORDER BY log_date DESC;

