
col column_name format a20
select column_name  from all_cons_columns
where owner='TASDBA' and constraint_name='&PK'
order by position;

