REM vim:ts=4:expandtab
REM
REM Jerzy.Kedra@gmail.com
REM SELECT * FROM v$sql_monitor WHERE username IS NOT NULL;
REM http://docs.oracle.com/cd/B28359_01/server.111/b28320/dynviews_3048.htm#REFRN30479
REM

COL user FORMAT A10
COL start_time HEADING 'start|time'
COL elapsed_time HEADING 'elapsed|time|minutes' FORMAT A7
COL disk_reads HEADING 'disk|reads'

SET HEADING ON
SELECT status,user,
	to_char(sql_exec_start, 'HH24:MI') start_time,
	LPAD(ROUND(elapsed_time/1024/1024/60,1), 6) elapsed_time,
    disk_reads,
	sql_id
FROM v$sql_monitor
WHERE username IS NOT NULL and status='EXECUTING'
ORDER BY status DESC, start_time DESC;


