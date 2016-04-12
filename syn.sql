COL target FORMAT A40
SET VERIFY OFF
SELECT table_owner||'.'||table_name target
FROM user_synonyms WHERE synonym_name=UPPER('&1');
