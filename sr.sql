SELECT role FROM session_roles
MINUS
SELECT granted_role FROM role_role_privs;
