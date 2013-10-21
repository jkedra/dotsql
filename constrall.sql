-- jxa
-- informacje o indeksie
--
SET ECHO OFF
SET VERIFY OFF
SET SERVEROUTPUT ON

col CONSTRAINT_NAME FORMAT A25
col SEARCH_CONDITION FORMAT A50

SELECT constraint_name,constraint_type,search_condition,status
FROM all_constraints WHERE table_name=UPPER('&table') and owner=UPPER('&owner');

