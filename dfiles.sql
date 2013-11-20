col fid format 99
col tablespace_name format a15
col file_name format a50
select tablespace_name,file_id fid,file_name
from dba_data_files
group by tablespace_name,file_id,file_name
/
col fid clear
