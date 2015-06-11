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
COL job_info		FORMAT A30 WORD_WRAPPED


ACCEPT vname  CHAR PROMPT "name []: "

SET FEEDBACK OFF
ALTER SESSION SET NLS_TIMESTAMP_FORMAT		= 'DD.MM HH24:MI:SS';
ALTER SESSION SET NLS_TIMESTAMP_TZ_FORMAT	= 'DD.MM HH24:MI:SS TZR';

SELECT window_name, window_start_time,
	job_start_time,job_duration duration,
	job_error joberr, job_info
FROM dba_autotask_job_history
WHERE job_name='&vname';

SET FEEDBACK ON

