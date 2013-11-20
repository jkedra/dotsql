col idx format a30
col pname format a30
col tblspc format a30
col deftblspc format a30
col file_name format a30
set linesize 160 
SET VERIFY OFF

select	a.index_name idx,a.partition_name pname,
	a.tablespace_name tblspc, round(d.bytes/1024/1024) MB,
	b.def_tablespace_name tdblspc,
	c.file_name
from dba_ind_partitions a, dba_part_indexes b, dba_data_files c, dba_segments d
where a.index_owner=b.owner and a.index_name=b.index_name
and a.tablespace_name=c.tablespace_name
and a.index_name=d.segment_name and a.index_owner=d.owner and a.partition_name=d.partition_name
and b.locality='LOCAL'
and b.table_name=UPPER('&tbl') and b.owner=NVL(UPPER('&owner'), USER)
order by a.index_name;

