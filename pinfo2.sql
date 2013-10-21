COL USERNAME FORMAT A20
COL OSUSER   FORMAT A8
--COL command  format 999999999


SET NUMWIDTH 7
SET VERIFY OFF

select s.sid,s.serial#,s.username,s.status,s.osuser,p.spid
from v$process p,v$session s
where s.paddr=p.addr
order by sid
/

--COL USERNAME CLEAR
--COL OSUSER   CLEAR

SET NUMWIDTH 10
SET VERIFY ON

