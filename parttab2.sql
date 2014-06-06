COL table_name FORMAT A15
COL partition_name FORMAT A15
COL tablespace_name FORMAT A20
COL def_tablespace_name FORMAT A20

SELECT a.table_name, a.partition_name, a.tablespace_name, b.def_tablespace_name
FROM dba_tab_partitions a,
	dba_part_tables b
WHERE a.table_owner=b.owner
  AND a.table_name=b.table_name
AND b.table_name='TASR_IVCLN' and b.owner='TASDBA'
ORDER BY table_name;
