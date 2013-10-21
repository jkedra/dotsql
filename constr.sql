-- jxa
-- informacje o indeksie
--
SET ECHO OFF
SET VERIFY OFF
SET SERVEROUTPUT ON

col CONSTRAINT_NAME FORMAT A12
col SEARCH_CONDITION FORMAT A30

select constraint_name,constraint_type,search_condition,status from user_constraints where table_name='&table'
/

