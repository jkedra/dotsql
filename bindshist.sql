COL col FORMAT a8
COL value_string FORMAT a20
col name FORMAT a8
col val FORMAT a20

SELECT to_char(end_interval_time, 'DD.MM HH24:MI') captured,
       name, datatype_string, was_captured,
       CASE WHEN datatype_string='TIMESTAMP'
       THEN TO_CHAR(anydata.accesstimestamp(value_anydata),
                    'YYYY.MM.DD HH24:MI:SS')
       ELSE value_string
       END val       
FROM dba_hist_sqlbind b, dba_hist_snapshot s
WHERE b.snap_id=s.snap_id
AND b.sql_id = '&sql_id'
ORDER BY b.SNAP_ID, b.position;

/*
SELECT name, datatype_string, was_captured,
       CASE WHEN datatype_string='TIMESTAMP'
       THEN TO_CHAR(anydata.accesstimestamp(value_anydata),
                    'YYYY.MM.DD HH24:MI:SS')
       ELSE value_string
       END val       
FROM v$sql_bind_capture
WHERE sql_id = 'abpfx340u8q81'
ORDER BY position;
*/


