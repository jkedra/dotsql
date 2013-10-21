SET NUMWIDTH 7
COL BSY FORMAT 999
prompt ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
prompt STA = STATUS          |
promp  ALC = ALLOCATION TYPE | USR=USER SYS=SYSTEM UNF=UNIFORM
prompt C   = CONTENTS        | P=PERMANENT T=TEMPORARY U=UNDO
prompt TSIZE in GB           | EXM=EXTENT MANAGEMENT LOC=LOCAL
prompt BSY - PERCENT BUSY    |                       DIC=DICTIONARY
prompt ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


select  a.tablespace_name,
        substr(decode(a.status, 'ONLINE', 'ONL',
                'OFFLINE', 'OFF', 'READ ONLY', 'R/O',
                a.status),1,3) STAT,
        substr(decode(a.allocation_type,
                'USER', 'USR',
                'SYSTEM', 'SYS',
                'UNIFORM', 'UNF',
                a.allocation_type),1,3) ALC,
        substr(decode(a.contents, 'PERMANENT', 'P',
                'TEMPORARY','T', a.contents),1,1) C,
	substr(decode(extent_management,'DICTIONARY','DIC',
		'LOCAL','LOC', extent_management),1,3) EXM,
        decode(a.contents||a.allocation_type,
                'TEMPORARYUNIFORM',
                (select round(sum(bytes/1024/1024/1024),3)
                from dba_temp_files
                where tablespace_name = a.tablespace_name),
                (select round(sum(bytes/1024/1024/1024),3)
                from dba_data_files
                where tablespace_name = a.tablespace_name)
        ) tssize,
	round(
	(	select sum(bytes)
		from dba_extents
		where tablespace_name=a.tablespace_name
	)/decode(a.contents||a.allocation_type,
                'TEMPORARYUNIFORM',
                (select sum(bytes)
                from dba_temp_files
                where tablespace_name = a.tablespace_name),
                (select sum(bytes)
                from dba_data_files
                where tablespace_name = a.tablespace_name)
        )*100) BSY
        from dba_tablespaces a

/
SET NUMWIDTH 10
COLUMN BSY CLEAR
