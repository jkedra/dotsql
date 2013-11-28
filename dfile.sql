-- Jerzy Kedra 2013

SET LINES 160

col file_name FORMAT A43
SELECT  TO_CHAR(file_id,'FM09')||'|'||
	CASE WHEN LENGTH(file_name) < 40
        THEN file_name
        ELSE '..' || substr(file_name,-38, 38)
        END file_name,
	tablespace_name,
	round(   bytes/1024/1024/1024,2) GB,
	round(maxbytes/1024/1024/1024,2) GB,
	autoextensible,
	increment_by incrby,
	status st,
	online_status onlnst
FROM dba_data_files;
