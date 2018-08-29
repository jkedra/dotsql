
COL description FORMAT A20
SET LINES 120

SELECT build_number,schema,description,scriptdate
FROM lps_active.lps_db_build ORDER BY scriptdate
/


