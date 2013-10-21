set verify off
select 'alter system kill session '''||sid||','||serial#||'''; ' sql from v$session where username=UPPER('&username')
and status='ACTIVE'
/
