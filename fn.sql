SET VERIFY OFF

SELECT FILE_NAME FROM dba_data_files where file_id=&1
/

SET VERIFY ON
