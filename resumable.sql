set linesize 120
set pagesize 120
column name heading 'Name' format a18
column status heading 'Status' format a20
column timeout heading 'Timeout' format 999999
column error_number heading 'Error Number' format 999999
column error_msg heading 'Message' format a44

select NAME,STATUS, TIMEOUT, ERROR_NUMBER, ERROR_MSG from DBA_RESUMABLE;
