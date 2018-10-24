
COL description FORMAT A20

SELECT description, build_number, schema, scriptdate
FROM lps_active.lps_db_build
ORDER BY scriptdate ASC;
