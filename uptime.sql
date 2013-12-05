
COL host_name FORMAT A20
COL host      FORMAT A20
select instance_name inst, host_name host, to_char(startup_time,'DD.MM.YY HH24:MM:SS') time
from gv$instance;


