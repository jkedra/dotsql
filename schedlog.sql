-- jurek@kedra.org
SET LINES 140
SET PAGES 80
SET VERIFY OFF
SET NUMWIDTH 6

COL log_date FORMAT A18 WORD_WRAPPED
COL owner    FORMAT A15 WORD_WRAPPED
COL job_name FORMAT A30
COL status   FORMAT A20

PROMPT By default only last 24hrs are displayed.
ACCEPT vdays      CHAR PROMPT "days [1]: "
ACCEPT vownexclre CHAR PROMPT "excl owners re ['^(SYS|EXFSYS|ORACLE_OCM|APEX.*)$']"

SET FEEDBACK OFF
ALTER SESSION SET NLS_TIMESTAMP_FORMAT          = 'DD.MM HH24:MI:SS';
ALTER SESSION SET NLS_TIMESTAMP_TZ_FORMAT       = 'DD.MM HH24:MI:SS TZR';
SET FEEDBACK ON


-- LOG_DATE                                    JOB_NAME          STATUS

SELECT TO_CHAR(log_date, 'DDMMYY HH24:MI:SS') log_date,
       owner, job_name, status
    FROM dba_scheduler_job_log
        WHERE log_date > SYSDATE - NVL('&vdays', '1')
          AND NOT REGEXP_LIKE(owner, NVL('&vownexclre', '^(SYS|EXFSYS|ORACLE_OCM|APEX.*)$'))
            ORDER BY log_date DESC;
