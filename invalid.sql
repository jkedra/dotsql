SET LINES 120
COL owner FORMAT a10
COL object_name FORMAT A40
COL object_TYPE FORMAT A20
select owner,object_name,object_type FROM dba_objects
	WHERE status='INVALID'
	AND owner IN ('TASDBA','TASGEN');
