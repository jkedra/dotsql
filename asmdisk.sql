col path format a40
col dskgrp FORMAT A10
set lines 160

select d.name,d.header_status,d.state,dg.name dskgrp, d.path
FROM v$asm_disk d, v$asm_diskgroup dg
WHERE d.group_number=dg.group_number (+)
/
