-- parameters: audit_trail=DB
-- audit create session whenever not successful;
COL os_username format A8
col username format A15
col userhost format A10
COL client_id FORMAT A20 WORD_WRAPPED
COL error FORMAT A30
SET LINES 160
SET VERIFY OFF

COL value FORMAT A10
COL parameter FORMAT A40
PROMPT UNIFIED AUDITING?
SELECT parameter, value
    FROM v$option
    WHERE parameter LIKE '%Auditing%';      


ACCEPT vhours NUMBER DEFAULT 1 PROMPT "hours back [1]: " 

SELECT username, userhost, client_id,
    TO_CHAR(timestamp, 'DD.MM.YYYY HH24:MI') evtime,
    DECODE(returncode, 1017, 'invalid username/password; logon denied',
           returncode, 28000, 'account locked',
           returncode) error
FROM sys.dba_audit_session
    WHERE action_name='LOGON'
      AND (username  IN ('TASUSR', 'TASGEN', 'ASDM', 'AUTOUSER', 'ZABBIX')
           OR REGEXP_LIKE(username, '..(WEB|BAT).$'))
      AND returncode<>0
      AND timestamp > SYSTIMESTAMP-&vhours./24
      ORDER BY timestamp DESC;   
