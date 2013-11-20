col sidser format a10
col username format a20

SELECT username,status,sid||','||serial# sidser from v$session
WHERE username='&username'
/

