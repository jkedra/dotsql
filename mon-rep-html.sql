SET LONG 10000000
SET LONGCHUNKSIZE 100000000
SET LINESIZE 10000
SET PAGESIZE 0
SET TRIM ON
SET TRIMSPOOL ON
SET ECHO OFF
SET FEEDBACK OFF

SPOOL /tmp/report_sql_monitor.html
SELECT DBMS_SQLTUNE.report_sql_monitor(
  sql_id       => '&sql_id%',
  type         => 'HTML',
  report_level => 'ALL') AS report
FROM dual;
SPOOL OFF

