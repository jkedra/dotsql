COL parameter FORMAT A30
COL value     FORMAT A30

PROMPT SESSION
SELECT * FROM nls_session_parameters;

PROMPT DATABASE
select * from V$NLS_PARAMETERS;
