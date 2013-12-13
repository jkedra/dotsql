# (c) Jerzy Kedra

PROMPT dba_stat_extensions (TASDBA)
SELECT * FROM dba_stat_extensions WHERE owner='TASDBA'; 

PROMPT dba_tab_modifications (TASDBA)

SELECT table_name,partition_name, inserts||'/'||updates||'/'||deletes idu,
       timestamp,truncated trunc,drop_segments drpsgs
FROM dba_tab_modifications WHERE table_owner='TASDBA'
ORDER BY timestamp ASC;
