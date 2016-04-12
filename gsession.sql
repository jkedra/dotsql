col sidser format a10
col username format a20
col machine format A10
COL process FORMAT 999999
COL osuser FORMAT A10
COL program FORMAT A10
SET LINES 120

SELECT username,status,sid||','||serial# sidser,
	SUBSTR(machine,1,10) machine, process, program, osuser
FROM gv$session
WHERE username='&username'
/

