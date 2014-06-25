COL table_name FORMAT A30
COL column_name FORMAT A30

SELECT table_name,column_name,count(*)
FROM user_tab_histograms
WHERE endpoint_actual_value IS NOT NULL
GROUP BY table_name,column_name
ORDER BY table_name,column_name;
