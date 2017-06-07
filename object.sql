SET VERIFY OFF
SET ECHO ON
COL OWNER FORMAT A20
SELECT distinct(object_name), owner, object_type FROM all_objects WHERE object_name like UPPER('%&1%')
order by object_name
/
SET ECHO OFF
