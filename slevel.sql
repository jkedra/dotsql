COLUMN statistics_name      FORMAT A30 HEADING "Statistics Name"
COLUMN session_status       FORMAT A10 HEADING "Session|Status"
COLUMN system_status        FORMAT A10 HEADING "System|Status"
COLUMN activation_level     FORMAT A10 HEADING "Activation|Level"
COLUMN session_settable     FORMAT A10 HEADING "Session|Settable"

SELECT statistics_name,
       session_status,
       system_status,
       activation_level,
       session_settable
FROM   v$statistics_level
ORDER BY statistics_name;

