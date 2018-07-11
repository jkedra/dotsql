SET LINES 2000
COL tbl FORMAT A30
COL cname FORMAT A30
COL t FORMAT A1
COL fk_cols FORMAT A60 WORD_WRAPPED

SELECT cc.table_name tbl, cc.constraint_name cname, c.constraint_type t,
       LISTAGG(cc.column_name, ', ') 
       WITHIN GROUP (ORDER BY position) fk_cols
       FROM user_cons_columns cc, user_constraints c
       WHERE c.owner=cc.owner
         AND c.constraint_name=cc.constraint_name
         AND c.constraint_type IN ('P', 'U')
       GROUP BY cc.table_name, cc.constraint_name, c.constraint_type;
