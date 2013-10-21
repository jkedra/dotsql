set linesize 120
set pagesize 120
column object_name heading 'Object Name' format a14
column object_type heading 'Object Type' format a14
column reason heading 'Reason' format a34
column suggested_action heading 'Suggested action' format a34

select OBJECT_NAME,OBJECT_TYPE,REASON,SUGGESTED_ACTION from DBA_OUTSTANDING_ALERTS;

