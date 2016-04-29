COL parameter FORMAT A30
COL value     FORMAT A30

PROMPT SESSION
SELECT * FROM nls_session_parameters
ORDER BY parameter;

PROMPT INSTANCE
SELECT * FROM nls_instance_parameters
ORDER BY parameter;

PROMPT DATABASE
SELECT * FROM nls_database_parameters
ORDER BY parameter;

