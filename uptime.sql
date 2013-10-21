
select instance_name inst, to_char(startup_time,'DD.MM.YY HH24:MM:SS') time
from gv$instance;


