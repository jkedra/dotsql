COL   sidser FORMAT A10
COL username FORMAT A10
COL machine  FORMAT A10
COL osuser   FORMAT A10
col action   FORMAT A20

SELECT username, sid||','||serial# sidser,
	ROUND(seconds_in_wait/60,0) waitmins,
	machine,osuser,action
FROM v$session
WHERE username IS NOT NULL
ORDER BY username,waitmins;

