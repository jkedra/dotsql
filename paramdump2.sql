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
	AND NAME IN ('control_file_record_keep_time',
                     'db_block_size', 'db_flashback_retention_target',
                     'db_recovery_file_dest_size', 'dispatchers',
                     'fast_start_mttr_target', 'job_queue_processes',
                     'max_shared_servers', 'nls_length_semantics',
                     'open_cursors', 'pga_aggregate_target', 'processes',
                     'resource_limit', 'session_cached_cursors',
                     'sessions', 'sga_max_size', 'sga_target',
                     'shared_servers', 'undo_retention', 'use_large_pages')
ORDER BY name,num;

