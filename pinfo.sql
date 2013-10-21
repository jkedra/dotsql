

COL USERNAME FORMAT A8
COL OSUSER   FORMAT A8
COL MACHINE  FORMAT A11
COL TERMINAL FORMAT A8
COL PROGRAM  FORMAT A8

SET NUMWIDTH 7
SET VERIFY OFF

select s.sid,s.serial#,s.username,s.command,s.osuser,s.machine,s.terminal,s.program
from v$process p,v$session s
where s.paddr=p.addr
and p.spid=&nr_procesu_servera
/

COL USERNAME CLEAR
COL OSUSER   CLEAR
COL MACHINE  CLEAR
COL TERMINAL CLEAR
COL PROGRAM  CLEAR

SET NUMWIDTH 10
SET VERIFY ON
