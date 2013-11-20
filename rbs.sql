-- (c) Jerzy Kedra, 16.06.2003
-- v0.1

COL ROLLBACK	FORMAT A25
COL MAXE/IE/NE	FORMAT A20

PROMPT segment_name(segment_id)@tablespace
PROMPT MXE = max_extents IE = initial_extent NE = next_extent
PROMPT values of extent size in MegaBytes

select	segment_name||'('||segment_id||')@'||tablespace_name rollback,SUBSTR(status,1,4) stat,
	max_extents ||'/'||
	round(initial_extent/1024/1024,2) ||'/'|| round(next_extent/1024/1024,2) "MAXE/IE/NE"
from dba_rollback_segs
/

COL ROLLBACK CLEAR
COL MAXE/IE/NE CLEAR
