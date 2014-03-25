
SET HEAD OFF
SET FEEDBACK OFF
SET ECHO OFF TERMOUT OFF
SET TRIMSPOOL ON
SET PAGES 0 LINES 2000
SET VERIFY OFF

select 'alter system kill session '''||sid||','||serial#||'''; ' sql from v$session where username=UPPER('&username')
/

SET HEAD ON FEEDBACK ON TERMOUT ON
SET PAGES 40
