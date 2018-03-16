--
-- (c) Jerzy Kedra
-- it shows FK for given table 
-- shows also parent tables and columns
--
/*

    SELECT owner, table_name, constraint_name fk,
            (SELECT LISTAGG(column_name, ', ')
                        WITHIN GROUP (ORDER BY position) fk_cols
             FROM all_cons_columns
             WHERE owner=c.owner AND constraint_name=c.constraint_name
             GROUP BY constraint_name) fk_cols,
           delete_rule,
           r_owner r_own, r_constraint_name r_constr,
            (SELECT LISTAGG(column_name, ', ')
                        WITHIN GROUP (ORDER BY position) fk_cols
             FROM all_cons_columns
             WHERE owner=c.r_owner AND constraint_name=c.r_constraint_name
             GROUP BY constraint_name) r_constr_cols       
    FROM all_constraints c
        WHERE constraint_type='R'
          AND owner='&table_owner' AND table_name='&table_name';

*/

set serveroutput on feedback off

set echo off
set verify off

col A NOPRINT NEW_VALUE USERNAME
-- default values
select decode(user,'APPDBA','TASDBA',
                   'TASGEN','TASDBA',
       user) A from dual;

accept OWNER PROMPT 'OWNER [&USERNAME]: ' DEFAULT &USERNAME
accept VTABLE PROMPT 'TABLE: '


declare
    vrefcol  all_cons_columns.column_name%TYPE;
    vchldcol all_cons_columns.column_name%TYPE;
    vreftbl  varchar2(512);
    vchldtbl  varchar2(512);    
begin
    for c IN
    (
        select owner, table_name, constraint_name, r_owner, r_constraint_name,
        (select owner||'.'||table_name from all_constraints where owner=a.r_owner and constraint_name=a.r_constraint_name) reftbl
        from all_constraints a
        where table_name=upper('&VTABLE') and owner=UPPER('&OWNER') and constraint_type='R'
    )
    loop
        vchldcol := '(';
        for c3 in
        (
            select * from all_cons_columns
            where owner=c.owner and constraint_name=c.constraint_name
            order by position
        )
        loop
            vchldcol := vchldcol || c3.column_name || ',';
            vchldtbl := c3.table_name;
        end loop;
        vchldtbl := vchldtbl || rtrim(vchldcol,',') || ')';
        
    
        vrefcol := '(';
        for c2 in
        (
            select * from all_cons_columns
            where owner=c.owner and constraint_name=c.r_constraint_name
            order by position
        )
        loop
            vrefcol := vrefcol || c2.column_name || ',';
            vreftbl := c2.table_name;
        end loop;
        vreftbl := vreftbl || rtrim(vrefcol,',') || ')';
        
        DBMS_OUTPUT.PUT_LINE('fk  : '||c.constraint_name);
        DBMS_OUTPUT.PUT_LINE('chld: '|| vchldtbl);
        DBMS_OUTPUT.PUT_LINE('prnt: '|| vreftbl);
        DBMS_OUTPUT.PUT_LINE('             -');
    end loop;
end;
/
set feedback on

