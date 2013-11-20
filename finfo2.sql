SET VERIFY OFF
COL ID FORMAT 999
COL TBLSPC FORMAT A15
SET NUMWIDTH 6
COL NAME FORMAT A22
COL USED FORMAT 999
PROMPT To moze chwile trwac...

SELECT file_id id,
	'..' || substr(file_name,-20, 20) name,
	bytes/1024/1024 MB,
	(	select sum(bytes) from dba_free_space
		where file_id=df.file_id
	)/bytes*100
	as free,
	substr(status,1,6) status,
	(  select status from v$datafile where file#=df.file_id ) status2,
	autoextensible, 
	round(maxbytes/1024/1024,1) MAX_MB,
	-- increment jest w blokach 
	round(increment_by*bytes/blocks/1024/1024,2) I_MB,
	tablespace_name tblspc
from dba_data_files df
where upper(file_name) like upper('%&1%')
order by id
/

SET VERIFY ON

COLUMN ID CLEAR

