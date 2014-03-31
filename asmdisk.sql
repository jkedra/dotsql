col path format a25
col name FORMAT A10
col label FORMAT A10
col dskgrp FORMAT A10
set lines 100

SELECT d.name,d.label, d.header_status,d.state,dg.name dskgrp, d.path
FROM v$asm_disk d, v$asm_diskgroup dg
WHERE d.group_number = dg.group_number (+)
/
