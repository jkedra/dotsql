-- dump from v$parameter
-- for non default values
-- used for database comparision

COL name FORMAT A30
COL display_value FORMAT A50
SET LINES 120

SELECT name,display_value
FROM v$parameter
WHERE (isdefault='FALSE' OR ismodified<>'FALSE')
	AND name NOT IN ('db_name','control_files','spfile','audit_file_dest',
	'log_archive_format')
ORDER BY name,num;

