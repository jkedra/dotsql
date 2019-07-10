ACCEPT days_to_search DEFAULT 1 PROMPT "days to search [1]: "

SELECT resource_name,max(max_utilization) maxutil,limit_value limit
    FROM dba_hist_resource_limit rl, 
         dba_hist_snapshot s
    WHERE rl.snap_id = s.snap_id
      AND rl.dbid = s.dbid
      AND begin_interval_time >= SYSDATE - &days_to_search
GROUP BY resource_name,limit_value;

