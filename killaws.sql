
ACCEPT username PROMPT 'username: '

SET HEAD OFF
SET FEEDBACK OFF
SET ECHO OFF TERMOUT OFF
SET TRIMSPOOL ON
SET PAGES 0 LINES 2000
SET VERIFY OFF

SPOOL /tmp/killaws-out.sql REPLACE

SELECT 'BEGIN'||CHR(10)||
       'RDSADMIN.RDSADMIN_UTIL.KILL(sid=>'||sid||', serial=>' ||serial#||
            ');'||CHR(10)||
       'END;'||CHR(10)|| '/'
    FROM gv$session
WHERE username=UPPER('&username');
SPOOL OFF

SET HEAD ON FEEDBACK ON TERMOUT ON
SET PAGES 40

@@/tmp/killaws-out.sql
