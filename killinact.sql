

ACCEPT killeduser DEFAULT none PROMPT 'Enter an user to kill: '
SET VERIFY OFF
SET PAGES 0
SET FEEDBACK OFF
SET TERMOUT OFF

SPOOL /tmp/spool-killinact.sql

PROMPT PROMPT KILLING USER &killeduser
SELECT 'ALTER SYSTEM KILL SESSION '''
    ||sid||','||serial#||'''; ' sql
    FROM v$session
        WHERE username=UPPER('&killeduser')
AND status='INACTIVE'
/

PROMPT PROMPT Done

SPOOL OFF

SET VERIFY ON
SET FEEDBACK ON
SET TERMOUT ON
