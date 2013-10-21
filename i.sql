
col index_type format a10
col index_name format a20
set verify off

ACCEPT owner PROMPT 'enter owner name: '
ACCEPT table PROMPT 'enter table name: '

select index_name,index_type, decode(uniqueness,'NONUNIQUE', 'NO', 'UNIQUE', 'YES') unq,
status from all_indexes where table_name='&table' and table_owner=NVL('&owner', USER)
/

col column_name format a20
break on index_name skip 1

select index_name,column_name,column_position P from user_ind_columns
where table_name='&table'
order by index_name,column_position
/

