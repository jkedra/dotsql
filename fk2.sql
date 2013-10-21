-- shows information about give FK name
--

SET VERIFY OFF FEEDBACK OFF

col A NOPRINT NEW_VALUE USERNAME
-- default values
select decode(user,'APPDBA','TASDBA',
                   'TASGEN','TASDBA',
       user) A from dual;

accept OWNER PROMPT 'OWNER [&USERNAME]: ' DEFAULT &USERNAME
accept VFK PROMPT 'FK: '



SET LINESIZE 90
COL column_name  FORMAT a40
COL table_name   FORMAT a40
COL parent_table FORMAT a40

SELECT table_name,column_name FROM all_cons_columns
WHERE owner=UPPER('&&OWNER')
	AND constraint_name=UPPER('&&VFK')
ORDER BY position;

SELECT table_name parent_table,column_name FROM all_cons_columns
WHERE (owner,constraint_name) IN
            (SELECT r_owner,r_constraint_name
             FROM all_constraints
             WHERE owner=UPPER('&&OWNER')
             AND constraint_name=UPPER('&&VFK')
             )
ORDER BY position;

