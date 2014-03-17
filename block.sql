-- LOCK
-- process 1234 always for JDBC
--
SET LINES 160
COL program FORMAT A30
COL sidser# FORMAT A10
select username,sid||'.'||serial# sidser#,
	BLOCKING_SESSION_STATUS,BLOCKING_INSTANCE,FINAL_BLOCKING_SESSION,
	substr(program,1,30) program,process
	from gv$session
	WHERE blocking_session_status='VALID';
