-- (c) Jerzy Kedra, 16.06.2003
-- v0.1

COL ROLLBACK	FORMAT A25
COL MAXE/IE/NE	FORMAT A20

PROMPT segment_name(segment_id)@tablespace
PROMPT MXE = max_extents IE = initial_extent NE = next_extent
PROMPT values of extent size in MegaBytes
PROMPT values of csize/optsize in MB
PROMPT csize = current size, optsize = optimal size



select	drs.segment_name||
	'('||drs.segment_id||')@'||drs.tablespace_name rollback,SUBSTR(drs.status,1,4) stat,
	drs.max_extents ||'/'||
	round(drs.initial_extent/1024/1024,2) ||'/'||
	round(drs.next_extent/1024/1024,2) "MAXE/IE/NE",
	round(rs.optsize/1024/1024,1) optsize ,
	round(ds.bytes/1024/1024,1) csize	
from dba_rollback_segs drs, v$rollstat rs, dba_segments ds
where drs.segment_id=rs.usn (+) and drs.segment_name=ds.segment_name
/

COL ROLLBACK CLEAR
COL MAXE/IE/NE CLEAR
