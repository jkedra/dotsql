-- vim:ts=4:expandtab
-- default & not null feature added:
-- ORA-14097 At Exchange Partition After Adding Column With Default Value (Doc ID 1334763.1).
-- http://blog.trivadis.com/b/danischnider/archive/2014/08/07/sherlock-holmes-and-partition-exchange.aspx
-- 
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
ACCEPT vtype   CHAR PROMPT "type  [ EXCH ]: "

PROMPT
PROMPT +======================================+
PROMPT |  N  - nullable   | H - hidden column |
PROMPT | ID - column id   |                   |
PROMPT |  C  - char used  |                   |
PROMPT +======================================+
(             SELECT 'ORG' tbl,
		     column_name,
                     data_type,
                     data_length len,
                     data_precision prec,
                     data_scale scale,
                     nullable,
                     char_used c,
                     DECODE(hidden_column, 'YES', 'Y', 'NO', '') h,
                     column_id id
                FROM all_tab_cols
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
                     char_used c,
                     DECODE(hidden_column, 'YES', 'Y', 'NO', '') h,
                     column_id id
                FROM all_tab_cols
               WHERE table_name = UPPER(NVL('&vtype.','EXCH')) ||
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
                     char_used c,
                     DECODE(hidden_column, 'YES', 'Y', 'NO', '') h,
                     column_id id
                FROM all_tab_cols
               WHERE table_name = UPPER(NVL('&vtype.','EXCH')) ||
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
                     char_used c,
                     DECODE(hidden_column, 'YES', 'Y', 'NO', '') h,
                     column_id id
                FROM all_tab_cols
               WHERE table_name = UPPER('&vtable')
                 AND owner= UPPER(NVL('&vschema','TASDBA'))
)               
ORDER BY 8;

PROMPT == unusual column properties ==
SELECT c.name, c.property
 FROM SYS.col$ c
 JOIN SYS.obj$ o ON (o.obj# = c.obj#)
 JOIN dba_users u ON (u.user_id = o.owner#)
WHERE o.NAME = UPPER('&vtable') AND u.username=UPPER(NVL('&vschema','TASDBA'))
AND c.property<>0;

PROMPT == dba_unused_col_tabs ==
SELECT table_name,count
FROM dba_unused_col_tabs
WHERE owner=UPPER(NVL('&vschema','TASDBA'))
  AND table_name=UPPER('&vtable');


