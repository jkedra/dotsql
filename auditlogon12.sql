-- parameters: audit_trail=DB
-- audit create session whenever not successful;
COL os_username format A8
COL dbusername FORMAT A8
col userhost format A10
COL client_program_name FORMAT A20 WORD_WRAPPED
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
      
SELECT dbusername, os_username, userhost, client_program_name,
    TO_CHAR(event_timestamp, 'DD.MM.YYYY HH24:MI') evtime,
    DECODE(return_code, 1017, 'invalid username/password; logon denied',
           return_code, 28000, 'account locked',
           return_code) error
FROM sys.UNIFIED_AUDIT_TRAIL
    WHERE action_name='LOGON'
      AND (dbusername  IN ('TASUSR', 'TASGEN', 'ASDM', 'AUTOUSER', 'ZABBIX')
           OR REGEXP_LIKE(dbusername, '..(WEB|BAT).$'))
      AND return_code<>0
      AND event_timestamp > SYSTIMESTAMP-&vhours./24
      ORDER BY event_timestamp DESC;   
