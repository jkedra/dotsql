col sidser format a10
col username format a20

SELECT username,inst_id,count(*) from gv$session
WHERE username IS NOT NULL
GROUP BY username,inst_id
ORDER BY username,inst_id
/

