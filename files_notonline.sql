COL name format a40
SET LINESIZE 100

select  file#,v.name,v.status,d.tablespace_name tablespace from v$datafile v, dba_data_files d
where v.status not in ('ONLINE','SYSTEM') and v.file#=d.file_id
/

