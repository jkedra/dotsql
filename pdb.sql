--
--
-- https://www.carajandb.com/en/blog/2017/help-where-am-i-cdb-or-pdb-and-which-db-anyway/
--
--

COL db_name FORMAT A20
COL type FORMAT A6

select decode(sys_context('USERENV', 'CON_NAME'),'CDB$ROOT',sys_context('USERENV', 'DB_NAME'),sys_context('USERENV', 'CON_NAME')) DB_NAME,
            decode(sys_context('USERENV','CON_ID'),1,'CDB','PDB') TYPE 
       from DUAL;

