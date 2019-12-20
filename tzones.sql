-- https://docs.oracle.com/en/database/oracle/oracle-database/12.2/nlspg/datetime-data-types-and-time-zone-support.html
COL tzname FORMAT A35
COL tzabbrev FORMAT A10


SELECT tzname, tzabbrev 
FROM v$timezone_names
ORDER BY tzname, tzabbrev;

SELECT dbtimezone FROM dual;
