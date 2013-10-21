/*
SELECT user_id, session_id, error_number, error_msg, suspend_time
FROM dba_resumable;
Related Event Information 	SELECT sid, event, seconds_in_wait
FROM gv$session_wait
WHERE sid = 140;
Other related information 	SELECT event, total_waits, time_waited
FROM gv$system_event
WHERE event like '%suspend%';
Other related information 	SELECT sid, event, total_waits, time_waited
FROM gv$session_event
WHERE event LIKE '%suspend%';
*/

select session_id,status,timeout,name,error_msg from dba_resumable;
