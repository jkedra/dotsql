SET LINES 160
COL username FORMAT A16
COL profile FORMAT A20
COL account_status FORMAT A20
select username,profile,account_status,lock_date,expiry_date from dba_users;
