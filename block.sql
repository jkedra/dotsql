-- LOCK
-- process 1234 always for JDBC
--
SET LINES 160
COL program  FORMAT A30
COL sidser#  FORMAT A10
COL username FORMAT A12
select username,sid||'.'||serial# sidser#,
	blocking_session_status,blocking_instance,final_blocking_session,
	substr(program,1,30) program,process
FROM gv$session
WHERE blocking_session_status='VALID'
ORDER BY final_blocking_session;
	
	
