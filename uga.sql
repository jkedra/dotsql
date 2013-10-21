col username format a15

select * from (
select  round(b.value/1024) KB,c.username,c.sid
from    v$statname a,v$sesstat b, v$session c
where   b.sid=c.sid
        and b.statistic# = a.statistic#
        and a.name = 'session uga memory'
        and b.value > 0
order by b.value desc
)
where rownum < 10
/
col username clear

