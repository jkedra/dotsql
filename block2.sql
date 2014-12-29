-- LOCK
-- process 1234 always for JDBC
--
SET LINES 160
COL program  FORMAT A30
COL sidser  FORMAT A30
COL username FORMAT A12
SELECT  count(*) sessions_blocked,
	s.final_blocking_session||','||ss.serial# sider
FROM gv$session s, gv$session ss
WHERE s.blocking_session_status='VALID'
  AND s.final_blocking_session=ss.sid
GROUP BY s.final_blocking_session, ss.serial#
ORDER BY sessions_blocked desc,s.final_blocking_session;
	
	
