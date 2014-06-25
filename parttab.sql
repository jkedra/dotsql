
SELECT a.table_name,a.partition_name,a.tablespace_name,round(d.bytes/1024/1024) MB, b.def_tablespace_name,c.file_name
from dba_tab_partitions a, dba_part_tables b, dba_data_files c, dba_segments d
where a.table_owner=b.owner and a.table_name=b.table_name
and a.tablespace_name=c.tablespace_name
and a.table_name=d.segment_name and a.table_owner=d.owner and a.partition_name=d.partition_name
and b.table_name='ASDR_IVC' and b.owner='ASDM'
order by table_name;
