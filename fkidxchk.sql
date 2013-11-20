SET LINES 160
COL table_name      FORMAT A20
COL constraint_name FORMAT A20
COL columns         FORMAT A80

SELECT table_name, constraint_name,
     cname1 || nvl2(cname2,','||cname2,null) ||
     nvl2(cname3,','||cname3,null) || nvl2(cname4,','||cname4,null) ||
     nvl2(cname5,','||cname5,null) || nvl2(cname6,','||cname6,null) ||
     nvl2(cname7,','||cname7,null) || nvl2(cname8,','||cname8,null)
            columns
  FROM ( SELECT b.table_name,
                b.constraint_name,
                max(decode( position, 1, column_name, null )) cname1,
                max(decode( position, 2, column_name, null )) cname2,
                max(decode( position, 3, column_name, null )) cname3,
                max(decode( position, 4, column_name, null )) cname4,
                max(decode( position, 5, column_name, null )) cname5,
                max(decode( position, 6, column_name, null )) cname6,
                max(decode( position, 7, column_name, null )) cname7,
                max(decode( position, 8, column_name, null )) cname8,
                COUNT(*) col_cnt
           FROM (SELECT SUBSTR(table_name,1,30) table_name,
                        SUBSTR(constraint_name,1,30) constraint_name,
                        SUBSTR(column_name,1,30) column_name,
                        position
                   FROM user_cons_columns ) a,
                user_constraints b
          WHERE a.constraint_name = b.constraint_name
            AND b.constraint_type = 'R'
          GROUP BY b.table_name, b.constraint_name
       ) cons
 WHERE col_cnt > ALL
         ( SELECT count(*)
             FROM user_ind_columns i
            WHERE i.table_name = cons.table_name
              AND i.column_name in (cname1, cname2, cname3, cname4,
                                    cname5, cname6, cname7, cname8 )
              AND i.column_position <= cons.col_cnt
            GROUP BY i.index_name
         )
 ORDER BY table_name,constraint_name
/
