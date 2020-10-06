COL username FORMAT A16
SELECT du.username, NVL(ROUND(SUM(bytes)/1024/1024/1024, 2), 0) GB
FROM dba_segments ds, dba_users du
WHERE (  du.username LIKE 'LPS%' OR
         du.username IN ('AT','ATGUEST','ACTIVE_MQ', 'COMM') )
      AND du.username =  ds.owner (+)
GROUP BY username
ORDER BY username ASC;


