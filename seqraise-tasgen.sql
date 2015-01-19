-- vim:ts=4:expandtab
DECLARE
tableview_notexist EXCEPTION;
PRAGMA exception_init(tableview_notexist, -942);
table_pattern VARCHAR2(128);
vsqlmaxtbl VARCHAR2(256);
vsqlseq VARCHAR2(256);
cnttbl INTEGER;
cntseq INTEGER;
vschema_owner VARCHAR2(30);
--
-- all_tables ->
--       all_sequeces with names like the table one ->
--          all_tab_columns like "ID"
--
BEGIN
    SELECT value INTO vschema_owner FROM adm_setup WHERE property='SCHEMA OWNER';
    
    FOR t IN (SELECT * FROM all_tables WHERE owner=vschema_owner)
    LOOP
        table_pattern := REGEXP_REPLACE(t.table_name, '(TASR|FISR)_(.*)', '\2');
        FOR s IN (SELECT * FROM all_sequences
                      WHERE sequence_owner=vschema_owner
                        AND REGEXP_LIKE(sequence_name, table_pattern||'(\$\d+)?$' )
                 )
        LOOP
            cntseq := s.last_number;
            -- just assume column ID is always related with SEQ
            FOR i IN (SELECT * FROM all_tab_columns
                         WHERE owner=vschema_owner
                           AND table_name=t.table_name AND column_name='ID')
            LOOP
            BEGIN
                vsqlmaxtbl := 'SELECT MAX('||i.column_name||') FROM '||t.owner||'.'||t.table_name;
                --DBMS_OUTPUT.PUT_LINE(vsqlmaxtbl);
                EXECUTE IMMEDIATE vsqlmaxtbl INTO cnttbl;
                IF cnttbl IS NULL THEN
                    cnttbl := 0;
                END IF;
                DBMS_OUTPUT.PUT_LINE(t.table_name||'('||cnttbl||'): '||s.sequence_name||'('||cntseq||')' );
                IF cnttbl > cntseq THEN
                LOOP
                     vsqlseq := 'SELECT '||s.sequence_owner||'.'||s.sequence_name||'.NEXTVAL FROM dual';
                     EXECUTE IMMEDIATE vsqlseq INTO cntseq;
                     EXIT WHEN cntseq >= cnttbl;
                END LOOP;
                END IF;
                DBMS_OUTPUT.PUT_LINE(t.table_name||'('||cnttbl||'): '||s.sequence_name||'('||cntseq||')' );
            EXCEPTION
                WHEN tableview_notexist THEN
                    DBMS_OUTPUT.PUT_LINE('[INFO] Object not exists T:'||t.table_name||' SQ:'||s.sequence_name);
            END;
            END LOOP;
        END LOOP;
    END LOOP;
END;
/

