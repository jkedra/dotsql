-- compare tables (arch)
SET LINESIZE 120
SET VERIFY OFF
COL column_name format A20
COL data_type   FORMAT A15
COL len FORMAT B999
COL prec FORMAT B999
COL scale FORMAT B999
COL id FORMAT B999

ACCEPT type PROMPT 'table type (ARCH or EXCH): '
ACCEPT table PROMPT 'table name: '

(             SELECT 'as in &&type' src,
                     column_name,
                     data_type,
                     data_length len,
                     data_precision prec,
                     data_scale scale,
                     nullable,
                     column_id id
                FROM user_tab_columns
               WHERE table_name = '&&table'
              MINUS
              SELECT 'as in &&type' src,
                     column_name,
                     data_type,
                     data_length len,
                     data_precision prec,
                     data_scale scale,
                     nullable,
                     column_id id
               FROM user_tab_columns
               WHERE table_name = '&&type._' ||
                    UPPER ('&&table')
)
UNION
(                  
              SELECT 'as in table' src,
                     column_name,
                     data_type,
                     data_length len,
                     data_precision prec,
                     data_scale scale,
                     nullable,
                     column_id id
                FROM user_tab_columns
               WHERE table_name = '&&type._' ||
                    UPPER ('&&table')                    
             MINUS
             SELECT  'as in table' src,
                     column_name,
                     data_type,
                     data_length len,
                     data_precision prec,
                     data_scale scale,
                     nullable,
                     column_id id
                FROM user_tab_columns
               WHERE table_name = '&&table'
)               
ORDER BY id, src;

