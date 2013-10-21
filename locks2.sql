SET ECHO OFF LINES 120
COL sid FORMAT A10
COL LOCK_TYPE FORMAT A10
COL modreq FORMAT A10
COL blocking FORMAT A10
COL usern FORMAT A10
COL schema FORMAT A10
COL machine FORMAT a10
COL process FORMAT a10
COL program FORMAT a10

select SUBSTR(s.username,1,10) usern,
	SUBSTR(s.schemaname,1,10) schema,
	SUBSTR(s.machine, 1,10) machine,
	SUBSTR(s.process, 1,10) process,
	SUBSTR(s.program, 1,10) program,
	s.sid||'.'||s.serial# sid,
	l.lock_type, l.mode_requested modreq,
	l.blocking_others blocking
FROM dba_locks l, v$session s
WHERE l.session_id=s.sid
AND lock_type NOT IN ('Media Recovery', 'Control File', 'Redo Thread', 'AE')
AND s.username IS NOT NULL;

SET ECHO ON;
