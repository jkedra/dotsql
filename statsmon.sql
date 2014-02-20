-- jerzy.kedra@sabre.com
-- vim:ts=4
-- statsmon.sql: monitoring concurrent statistics job

SET lines 160
COL comments FORMAT A30
SELECT job_name, state, comments FROM dba_scheduler_jobs
	WHERE job_class LIKE 'CONC%';
