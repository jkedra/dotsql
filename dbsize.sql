COL "Database Size" FORMAT A20
COL "Free space" FORMAT A20
select round(sum(used.bytes) / 1024 / 1024/ 1024 ) || ' GB' "Database Size" 
,      round(free.p / 1024 / 1024/ 1024) || ' GB' "Free space" 
from (select bytes from v$datafile 
      union all 
      select bytes from v$tempfile 
      union all 
      select bytes from v$log) used 
,    (select sum(bytes) as p from dba_free_space) free 
group by free.p ;
