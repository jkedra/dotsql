-- DESC:	script to synchronize sequences between Prod and cert databases.
-- authors: tomasz.antonik, Jurek Kedra
-- date: 	2012-2017

set feedback off
set lines 120
SET PAGES 0

-- GLOBAL_NAME     (capital let)
-- GLOBAL_NAME_LOW (low letters)
-- SCHEMA_NAME_LOW (low letters)
COL p1 NEW_VALUE GLOBAL_NAME
COL p2 NEW_VALUE GLOBAL_NAME_LOW
SELECT REGEXP_REPLACE(global_name,'\..*') p1,
       LOWER(REGEXP_REPLACE(global_name,'\..*')) p2
    FROM global_name;
COL p1 CLEAR
COL p2 CLEAR


SPOOL sync_sequences_&GLOBAL_NAME..sql

prompt SET SERVEROUT ON
prompt 
prompt DECLARE
prompt    TYPE DD IS TABLE OF NUMBER
prompt       INDEX BY VARCHAR2 (30);;
prompt 
prompt    T_DD   DD;;
prompt    CNT    NUMBER := 0;;
prompt BEGIN


select 'T_DD ('''||SEQUENCE_NAME ||''') := '||LAST_NUMBER||';' from all_sequences
where sequence_owner='TASDBA';

prompt    FOR I IN (SELECT *
prompt                FROM all_sequences
prompt               WHERE sequence_owner = 'TASDBA')
prompt    LOOP
PROMPT     IF t_dd.EXISTS(i.sequence_name)
PROMPT      THEN
prompt       FOR J IN (I.LAST_NUMBER + 1) .. T_DD (I.SEQUENCE_NAME)
prompt       LOOP
prompt          EXECUTE IMMEDIATE
prompt                '
prompt             DECLARE
prompt                 RET NUMBER;;
prompt             BEGIN
prompt                 SELECT TASDBA.'
prompt             || I.SEQUENCE_NAME
prompt             || '.NEXTVAL INTO RET FROM DUAL;;
prompt             END;;
prompt             ';;
prompt 
prompt          CNT := CNT + 1;;
prompt       END LOOP;;
prompt      END IF;;
prompt       if cnt > 0 then
prompt         DBMS_OUTPUT.PUT_LINE (I.SEQUENCE_NAME || ' PLUS : ' || CNT);;
prompt       end if;;
prompt       CNT := 0;;
prompt    END LOOP;;
prompt END;;
prompt /
spool off

-- connect to dev/cert db as tasgen and run it
-- set serveroutput on;
-- @script.sql


