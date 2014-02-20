# (c) Jerzy Kedra

SET LINES 200
COL extension FORMAT A20
PROMPT dba_stat_extensions (TASDBA)
SELECT * FROM dba_stat_extensions WHERE owner='TASDBA'; 

PROMPT dba_tab_modifications (TASDBA)

COL table_name		FORMAT A25
COL partition_name	FORMAT A15
COL timestamp		FORMAT A18
COL idu			FORMAT A15
COL DRPSGS		FORMAT 999

SELECT table_name,partition_name, inserts||'/'||updates||'/'||deletes idu,
       timestamp,truncated trunc,drop_segments drpsgs
FROM dba_tab_modifications WHERE table_owner='TASDBA'
ORDER BY timestamp ASC;
