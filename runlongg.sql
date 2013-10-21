COL inst_name FORMAT a20

--BREAK ON username
select username,substr(inst_name,1,20) inst_name,count(*) from gv$session s, v$active_instances ai
where status='ACTIVE' and username is not null and inst_id=inst_number
group by username,inst_name
order by username,inst_name
/
