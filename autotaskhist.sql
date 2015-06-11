-- jurek@kedra.org
-- http://docs.oracle.com/cd/E11882_01/server.112/e25494/tasks.htm
SET LINES 140
SET PAGES 80
SET VERIFY OFF
SET NUMWIDTH 6

COL window_name		FORMAT A16 TRUNCATED
COL window_start_time	FORMAT A21
COL window_start_time   FORMAT A16 WORD_WRAPPED
COL job_start_time	FORMAT A16 WORD_WRAPPED
COL job_duration	FORMAT A16
COL duration            FORMAT A10 TRUNCATED
COL job_name		FORMAT A21
COL job_info		FORMAT A30 TRUNCATED

PROMPT By default only last 24hrs are displayed.
ACCEPT vdays  CHAR PROMPT "days [1]: "

SET FEEDBACK OFF
ALTER SESSION SET NLS_TIMESTAMP_FORMAT		= 'DD.MM HH24:MI:SS';
ALTER SESSION SET NLS_TIMESTAMP_TZ_FORMAT	= 'DD.MM HH24:MI:SS TZR';

SELECT window_name, window_start_time,
	job_name,job_start_time,job_duration duration,
	job_error err,job_info
FROM dba_autotask_job_history
WHERE job_start_time > SYSDATE - NVL('&vdays', '1')
ORDER BY window_start_time;

SET FEEDBACK ON

PROMPT Use following query for job name description:
PROMPT SELECT * FROM DBA_AUTOTASK_OPERATION;

