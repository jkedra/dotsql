-- http://kerryosborne.oracle-guy.com/2009/04/oracle-11g-sql-plan-management-sql-plan-baselines/
set lines 155
col sql_text for a30 trunc
col last_executed for a28
col enabled for a3
col plan_hash_value for a16
col last_executed for a16

COL SQL_HANDLE FORMAT A20
COL PLAN_NAME FORMAT A20

SELECT spb.sql_handle, spb.plan_name, spb.sql_text,
spb.enabled, spb.accepted, spb.fixed,
to_char(spb.last_executed,'dd-mm-yy HH24:MI') last_executed,
    origin
FROM DBA_SQL_PLAN_BASELINES spb
WHERE spb.sql_text like nvl('%'||'&sql_text'||'%',spb.sql_text)
and spb.sql_handle like nvl('&name',spb.sql_handle)
and spb.plan_name like nvl('&plan_name',spb.plan_name)
/
