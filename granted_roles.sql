
BREAK ON grantee SKIP 1
SELECT		grantee,granted_role
FROM		dba_role_privs
GROUP BY	grantee,granted_role
/

