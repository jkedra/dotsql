-- jurek@kedra.org
SET LINES 140
SET PAGES 80
SET VERIFY OFF
SET NUMWIDTH 6

COL last_start_date FORMAT A15 WORD_WRAPPED
COL next_start_date FORMAT A15 WORD_WRAPPED
COL log_date FORMAT A18 WORD_WRAPPED
COL owner    FORMAT A10 WORD_WRAPPED
COL repeat_interval FORMAT A20 TRUNCATED
COL job_name FORMAT A30
COL status   FORMAT A20
COL state    FORMAT A5 TRUNCATE

PROMPT E=ENABLED Y/N
DEFINE vownexclre_default='^(SYS|EXFSYS|ORACLE_OCM|APEX.*)$'
ACCEPT vownexclre CHAR PROMPT "excl owners re ['&vownexclre_default.']: "

SET FEEDBACK OFF
ALTER SESSION SET NLS_TIMESTAMP_FORMAT          = 'DD.MM HH24:MI:SS';
ALTER SESSION SET NLS_TIMESTAMP_TZ_FORMAT       = 'DD.MM HH24:MI:SS TZR';
SET FEEDBACK ON


-- LOG_DATE                                    JOB_NAME          STATUS
SELECT owner, job_name, repeat_interval,
       state,
       decode(enabled, 'TRUE', 'Y', 'FALSE', 'N') enabled,
       to_char(last_start_date, 'DDMMYY HH24:MI TZR') last_start_date,
       to_char(next_run_date,   'DDMMYY HH24:MI TZR') next_start_date
FROM dba_scheduler_jobs
WHERE NOT regexp_like(owner, NVL('&vownexclre', '&vownexclre_default.'));

/*
          AND NOT REGEXP_LIKE(owner, NVL('&vownexclre', '^(SYS|EXFSYS|ORACLE_OCM|APEX.*)$'))
            ORDER BY log_date DESC;
*/
