-- restore points
-- Jerzy Kedra
COL RESTORE_POINT FORMAT A20

SELECT name restore_point,
        GUARANTEE_FLASHBACK_DATABASE GFD,
        round(storage_size/1024/1024/1024, 2) GB,
to_char(time, 'YYYY.MM.DD HH24:MI') restore_date from v$restore_point;


