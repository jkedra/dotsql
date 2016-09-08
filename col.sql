COL data_type FORMAT a10

SET VERIFY OFF

SELECT table_name,data_type,data_length
FROM user_tab_columns
WHERE column_name=UPPER('&1');

SET VERIFY ON


