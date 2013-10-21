-- (c) Jerzy Kêdra 01.2003 

SET FEEDBACK OFF

col opname format a10
col target format a10
col total  format 99999
col start_time format a5
col totalwork  format 999
col minutes_elapsed format 9999.9
col message format a20
col username format a8
col unit format a3
col time_remaining  format 9999.9
col elapsed_seconds format 99999

col time_remaining	HEADING "Minutes|Remain"
col minutes_elapsed	HEADING "Minutes|Elapse"
col totalwork		HEADING "Work|%"
col start_time		HEADING "Start|Time"

SET TERMOUT OFF
ALTER SESSION SET NLS_DATE_FORMAT='HH24:MI';
SET TERMOUT ON

SELECT  target,round(sofar/totalwork*100) totalwork,
	start_time,
	round(time_remaining/60,1) time_remaining,
	round(elapsed_seconds/60,1) minutes_elapsed,
	message,username
FROM	v$session_longops
WHERE	sofar <> totalwork
/

COLUMN time_remaining CLEAR
COLUMN minutes_elapsed CLEAR
COLUMN totalwork CLEAR
COLUMN start_time CLEAR

SET FEEDBACK 6

