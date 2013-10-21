col column_name format a30
break on index_name skip 1

col index_name  format a20
set verify off

ACCEPT owner PROMPT 'enter owner name: '
ACCEPT table PROMPT 'enter table name: '


SELECT index_name,lpad(column_position,2)||' '||column_name column_name
FROM ALL_IND_COLUMNS
WHERE  table_owner=UPPER(NVL('&owner',USER)) AND table_name=UPPER('&table');

CLEAR BREAKS
