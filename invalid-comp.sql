-- vim:ts=4:expandtab
SET LINES 120
COL owner FORMAT a10
COL object_name FORMAT A40
COL object_TYPE FORMAT A20

SET SERVEROUTPUT ON
DECLARE
    s   VARCHAR2(4000);
BEGIN
    FOR c IN (SELECT owner,object_name,object_type FROM dba_objects
	          WHERE status='INVALID'
	          AND owner IN ('TASDBA','TASGEN')
             )
    LOOP
        s:='ALTER '||c.object_type||' '||c.owner||'.'||c.object_name
           ||' COMPILE';
        BEGIN
            EXECUTE IMMEDIATE s;
            DBMS_OUTPUT.PUT_LINE(s||'; # OK');
        EXCEPTION
        WHEN OTHERS THEN
           DBMS_OUTPUT.PUT_LINE(s||'; # FAIL');
        END;
    END LOOP;
END;
/
