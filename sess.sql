COL   sidser FORMAT A10
COL username FORMAT A10
COL machine  FORMAT A10
COL osuser   FORMAT A10
col action   FORMAT A20

SET LINES 100

SELECT username, sid||','||serial# sidser,
	ROUND(seconds_in_wait/60,0) waitmins,
	machine,osuser,action,status
FROM gv$session
WHERE NOT (username IS NULL
           OR username IN ('SYS', 'DBSNMP'))
ORDER BY username,waitmins;

