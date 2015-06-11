SELECT resource_name,max(max_utilization) maxutil,limit_value limit
FROM DBA_HIST_RESOURCE_LIMIT
GROUP BY resource_name,limit_value;

