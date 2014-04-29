col max_open_cur format A20
col machine FORMAT A20
COL username FORMAT A10
col client_info format a20
col sidser FORMAT A10

select a.sid||'.'||s.serial# sidser, s.username, s.machine, s.client_info,
  max(a.value) as highest_open_cur, p.value as max_open_cur
  from v$sesstat a, v$statname b, v$parameter p, v$session s
   where a.statistic# = b.statistic#
   and s.sid=a.sid
   and b.name = 'opened cursors current'
   and p.name= 'open_cursors'
	AND s.username IS NOT NULL
  GROUP BY 	a.sid||'.'||s.serial#,
		s.username,s.machine, s.client_info, p.value
  HAVING max(a.value) > 10
  ORDER BY highest_open_cur ASC
/

