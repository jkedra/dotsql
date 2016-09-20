-- DESC:	script to synchronize sequences between Prod and cert databases.
-- author: 	tomasz.antonik
-- date: 	2012.07.12
-- usage: 	@sync_seq <prod_sid> 

set feedback off
set lines 120
SET PAGES 0

spool sync_sequences_result.sql

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






