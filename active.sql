select username,count(*) from v$session
where status='ACTIVE' and username is not null
group by username
/
