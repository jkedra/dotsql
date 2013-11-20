COL tempfile FORMAT A40
COL tablespace_name FORMAT A30

select file_id,
	CASE WHEN LENGTH(file_name) < 38
    	THEN file_name
    	ELSE '..' || substr(file_name,-38, 38)
    	END
	tablespace_name,
	ROUND(bytes/1024/1024) MB,
autoextensible aut, ROUND(maxbytes/1024/1024) MAXMB from dba_temp_files;

COL tempfile CLEAR
COL tablespace_name CLEAR

