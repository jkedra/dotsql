SET ECHO OFF

col username format a20
col mode_requested format a10
col lock_type format a15

select	username || ':' || sid || ',' || serial# username,
	to_char(logon_time, 'DD.HH24:MI') "LOGTIME",
	lock_type,mode_requested
from v$session s,dba_locks l
where session_id=sid and username is not null
/

col lock_type format a15
col mode_requested clear
col username clear


