select tablespace_name,round(bytes/1024/1024) MB, round(max_bytes/1024/1024)
from dba_ts_quotas where username=upper('&1')
/
