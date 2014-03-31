set lines 160
col name format a15

PROMPT T=TYPE (E=EXTERN)
select group_number||':'||name name,
	DECODE(type, 'EXTERN', 'E', type) T,
	ROUND(total_mb/1024,2) GB,
	ROUND(usable_file_mb/total_mb*100, 2) PCT_FREE,
	ROUND(usable_file_mb/1024,2) USABLE from v$asm_diskgroup;

