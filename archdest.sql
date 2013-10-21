
set numwidth 4
col destination format a20
col error format a20

select dest_id id,status,destination,error
from v$archive_dest;

