
SET LINES 200
COL USERNAME FORMAT A16
COL account_status FORMAT A20
COL profile        FORMAT A18

SELECT username,profile,account_status,lock_date,expiry_date
	FROM dba_users
	WHERE username LIKE 'APP%'
		OR username LIKE 'TAS%'
		OR username LIKE 'AA%'
		OR username LIKE 'ASV%'
        OR username LIKE 'LPS%'
		OR username IN ('OEMDEFAULT', 'ASDM', 'AUTOUSER');

SELECT DISTINCT profile
	FROM dba_profiles;

COL PROFILE FORMAT A20
COL LIMIT FORMAT A20

BREAK ON profile

SELECT profile,resource_name,limit
	FROM dba_profiles
	WHERE profile IN ('MONITORING_PROFILE','DEFAULT', 'AMQ')
		OR profile LIKE 'SABRE%' OR profile LIKE 'LM%'
	ORDER by profile,resource_name;


CLEAR BREAKS

