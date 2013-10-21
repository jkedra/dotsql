SET LINESIZE 160

SELECT owner,table_name,constraint_name FROM all_constraints
WHERE (r_owner,r_constraint_name) =
(SELECT owner,constraint_name FROM all_constraints
 WHERE table_name=UPPER('&table') AND owner=NVL(UPPER('&owner'),user)
     AND constraint_type IN ('P','U')
 );

