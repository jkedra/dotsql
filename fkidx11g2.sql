COL status format a2
COL table_name format a25
COL columns format a40
COL fk_columns format a60
COL index_columns format a60
SET LINES 200

SELECT DECODE(b.table_name, NULL, '**', 'ok') status,
       a.table_name, a.columns fk_columns, b.columns index_columns, a.columns_pos, b.columns_pos
        FROM (SELECT a.table_name,
                    a.constraint_name,
                    LISTAGG(a.column_name, ',') within GROUP(ORDER BY a.position) columns,
                    LISTAGG(a.position, ',') within GROUP(ORDER BY a.position) columns_pos
                    FROM dba_cons_columns a,
                         dba_constraints b
                    WHERE a.constraint_name = b.constraint_name
                      AND b.constraint_type = 'R'
                      AND a.owner = b.owner
                        AND a.owner='TASDBA' 
                    GROUP BY a.table_name, a.constraint_name) a,
             (SELECT table_name, index_name,
                     LISTAGG(c.column_name, ',') within GROUP(ORDER BY c.column_position) columns,
                      LISTAGG(c.column_position, ',') within GROUP(ORDER BY c.column_position) columns_pos
                FROM dba_ind_columns c
                WHERE c.table_owner='TASDBA'
                GROUP BY table_name, index_name) b
WHERE a.table_name = b.table_name(+)
AND b.columns_pos(+) LIKE a.columns_pos || '%'
ORDER BY status, table_name;
