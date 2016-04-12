REM tablespace usage:
REM sizes IN GB

SELECT um.tablespace_name, ROUND(um.used_space * ts.block_size/1024/1024/1024) used,
                        ROUND(um.tablespace_size * ts.block_size/1024/1024/1024) maxsize,
			ROUND(used_percent) used_percent
FROM dba_tablespace_usage_metrics um, dba_tablespaces ts
	WHERE um.tablespace_name=ts.tablespace_name;

