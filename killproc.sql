select spid,PID,server from v$session a,v$process b where a.username=UPPER('&username')
and status='ACTIVE' and a.paddr=b.addr
/
