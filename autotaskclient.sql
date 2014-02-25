-- 25.02.2014
-- jurek@kedra.org
--
COL client_name			FORMAT A30 TRUNCATED
COL mean_job_duration		FORMAT A20
COL mean_duration		FORMAT A13
COL maxdur7days			FORMAT A13
COL MAX_DURATION_LAST_7_DAYS	FORMAT A20
SELECT client_name,status, 
	CAST(mean_job_duration        AS INTERVAL DAY(1) TO SECOND(0)) mean_duration,
	CAST(max_duration_last_7_days AS INTERVAL DAY(1) TO SECOND(0)) maxdur7days
FROM dba_autotask_client;
