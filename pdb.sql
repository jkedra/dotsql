--
--
-- https://www.carajandb.com/en/blog/2017/help-where-am-i-cdb-or-pdb-and-which-db-anyway/
--
--

COL db_name FORMAT A20
COL type FORMAT A6

SELECT DECODE(
            SYS_CONTEXT('USERENV', 'CON_NAME'),
            'CDB$ROOT', SYS_CONTEXT('USERENV', 'DB_NAME'),
            SYS_CONTEXT('USERENV', 'CON_NAME')
        ) DB_NAME,
       DECODE(SYS_CONTEXT('USERENV','CON_ID'),
            0,'NONCDB',
            1,'CDB',
            3,'PDB',
            SYS_CONTEXT('USERENV','CON_ID')
        ) TYPE 
       from DUAL;

