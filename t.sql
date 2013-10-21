SET VERIFY OFF
--SET ECHO ON
select file_id,file_name from dba_data_files where tablespace_name=upper('&1')
/
--SET ECHO OFF
