set verify off

col column_name format a25

select column_name,substr(comments,1,40) comm from
user_col_comments where table_name=UPPER('&1')
/

