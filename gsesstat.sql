-- vim:ts=4
SET lines 160
SET NUMWIDTH 4
col sidser format a10
col username format a20
col host_name format a10
col iname FORMAT A10
col service_name format a16


SELECT username,a.inst_id iid,instance_name iname,
	host_name,service_name,count(*) ses
FROM gv$session a, gv$instance b
WHERE a.inst_id=b.inst_id
	AND username IS NOT NULL
	AND service_name NOT IN ('SYS$BACKGROUND')
GROUP BY username,a.inst_id,instance_name,host_name,service_name
ORDER BY iid, username, service_name, ses
/

