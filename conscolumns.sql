-- jxa
-- informacje o kolumnach objetych indexem


COL constraint_name FORMAT A20
COL column_name FORMAT A20

SELECT constraint_name,column_name,position
FROM user_cons_columns
WHERE table_name=UPPER('&1');

