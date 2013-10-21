SET LINES 160
COL DATA_TYPE FORMAT A10
COL ID        FORMAT 999
COL SCALE     FORMAT 999
COL PREC      FORMAT 999
COL LEN       FORMAT 9999
SET VERIFY OFF
PROMPT TYPE can be ARCH or EXCH
ACCEPT vschema CHAR PROMPT "schema[TASDBA]: "
ACCEPT vtable  CHAR PROMPT "table [      ]: "
ACCEPT vtype   CHAR PROMPT "type  [ARCH  ]: "

(             SELECT 'ORG' tbl,
		     column_name,
                     data_type,
                     data_length len,
                     data_precision prec,
                     data_scale scale,
                     nullable,
                     column_id id
                FROM all_tab_columns
               WHERE table_name = UPPER('&vtable')
                 AND owner= UPPER(NVL('&vschema','TASDBA'))
              MINUS
              SELECT 'ORG' tbl,
                     column_name,
                     data_type,
                     data_length len,
                     data_precision prec,
                     data_scale scale,
                     nullable,
                     column_id id
                FROM all_tab_columns
               WHERE table_name = UPPER(NVL('&vtype.','ARCH')) ||
                                  '_'|| UPPER ('&vtable')
                 AND owner= UPPER(NVL('&vschema','TASDBA'))
)
UNION
(                  
              SELECT NVL('&vtype.','ARCH') tbl,
                     column_name,
                     data_type,
                     data_length len,
                     data_precision prec,
                     data_scale scale,
                     nullable,
                     column_id id
                FROM all_tab_columns
               WHERE table_name = UPPER(NVL('&vtype.','ARCH')) ||
                                  '_'|| UPPER ('&vtable')
                 AND owner= UPPER(NVL('&vschema','TASDBA'))
             MINUS
             SELECT  NVL('&vtype.','ARCH') tbl,
                     column_name,
                     data_type,
                     data_length len,
                     data_precision prec,
                     data_scale scale,
                     nullable,
                     column_id id
                FROM all_tab_columns
               WHERE table_name = UPPER('&vtable')
                 AND owner= UPPER(NVL('&vschema','TASDBA'))
)               
ORDER BY 8;
