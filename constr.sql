-- jxa
-- informacje o indeksie
--
SET ECHO OFF
SET VERIFY OFF
SET SERVEROUTPUT ON

col CONSTRAINT_NAME FORMAT A12
col SEARCH_CONDITION FORMAT A30

SELECT constraint_name,constraint_type,search_condition,status
FROM user_constraints
WHERE table_name='&table'
/

