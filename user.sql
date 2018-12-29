-- https://wchumz.wordpress.com/2013/08/01/alter-user-identified-by-values-oracle-11g/

SET ECHO OFF
SET VERIFY OFF
SET SERVEROUTPUT ON

ACCEPT user_name PROMPT 'Enter user name [SYS]  : ' DEFAULT SYS 

SELECT name,ptime,ctime,ltime,exptime
FROM sys.user$
    WHERE name='&user_name';

SELECT password_versions FROM dba_users
    WHERE username='&user_name';

SELECT name,defrole,lcount,password
FROM sys.user$
    WHERE name='&user_name';

COL password12 FORMAT A80
SELECT spare4 password12
FROM sys.user$
    WHERE name='&user_name';



