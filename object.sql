SET VERIFY OFF
SET ECHO ON
SELECT distinct(object_name) FROM all_objects WHERE object_name like UPPER('%&1%')
order by object_name
/
SET ECHO OFF
