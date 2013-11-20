col member format a35
select a.group#,a.bytes/1024/1024 MB,a.archived,a.status,b.member
from v$log a, v$logfile b where a.group#=b.group#
/
