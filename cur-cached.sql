col username format A20
col sidser format a10
SELECT a.value curr_cached, -p.value max_cached,
       s.username, s.sid||'.'||s.serial# sidser
  FROM v$sesstat a, v$statname b, v$session s, v$parameter2 p
 WHERE a.statistic# = b.statistic#  and s.sid=a.sid
   AND p.name='session_cached_cursors'
   AND b.name = 'session cursor cache count'
 ORDER BY curr_cached DESC
/

