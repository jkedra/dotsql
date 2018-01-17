COL os_username format A8
col userhost format A10
COL client_program_name FORMAT A20 WORD_WRAPPED
COL error FORMAT A30
SET LINES 160
SET VERIFY OFF

ACCEPT vhours NUMBER DEFAULT 1 PROMPT "hours back [1]: " 
      
SELECT os_username, userhost, client_program_name,
    TO_CHAR(event_timestamp, 'DD.MM.YYYY HH24:MI') evtime,
    DECODE(return_code, 1017, 'invalid username/password; logon denied',
           return_code) error
FROM sys.UNIFIED_AUDIT_TRAIL
    WHERE action_name='LOGON'
      AND dbusername='TASGEN'
      AND return_code<>28000
      AND event_timestamp > SYSTIMESTAMP-&vhours./24
      ORDER BY event_timestamp DESC;   
