COL SEGMENT_NAME FORMAT A10
select  segment_name,
	round(bytes/1024/1024,1) MB from dba_segments where segment_type='ROLLBACK'
/
