COL owner FORMAT A16
SELECT owner, ROUND(SUM(bytes)/1024/1024/1024,1) GB
    FROM dba_segments
        GROUP BY owner HAVING ROUND(SUM(bytes)/1024/1024/1024,1) > 0
        ORDER BY 2 DESC;

