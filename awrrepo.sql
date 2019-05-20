col SNAP_INTERVAL FORMAT A20
col retention FORMAT A20
col topnsql FORMAT A20

SELECT SNAP_INTERVAL, RETENTION, topnsql FROM dba_hist_wr_control;

select dbms_stats.get_stats_history_retention from dual;
 
select dbms_stats.get_stats_history_availability from dual;
