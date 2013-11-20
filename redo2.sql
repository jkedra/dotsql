SET lines 160
COL username FORMAT A15
COL state FORMAT A15

SELECT a.status, a.state, a.username, b.used_urec, b.used_ublk
--SELECT b.used_ublk
  FROM v$session a, v$transaction b
  WHERE a.saddr = b.ses_addr
/

-- and a.sid=240;

--exit;

