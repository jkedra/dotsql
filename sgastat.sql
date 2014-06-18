REM vim:ts=4:expandtab
REM SELECT pool, name, ROUND(bytes/1024/1024) mb FROM v$sgastat ORDER BY pool, mb ASC;

SELECT pool, name, mb
FROM (
    SELECT pool, name, mb,  ROW_NUMBER() OVER (PARTITION BY pool ORDER BY mb DESC) rn
    FROM
        (SELECT pool,name,ROUND(bytes/1024/1024) MB
	     FROM v$sgastat
        )
)
WHERE rn < 20
ORDER BY pool, rn DESC;
