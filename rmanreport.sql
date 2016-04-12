--
-- (c) Jerzy Kedra
-- If the report runs long just collect stats on dictionary.
-- EXEC dbms_stats.gather_fixed_objects_stats(null);
--

SPOOL /tmp/rmanreport.txt
COL global_name FORMAT A20
SELECT SYSDATE, global_name FROM global_name;

SET LINES 150
COL duration FORMAT A8
COL output_size FORMAT A10
COL archbkpsize FORMAT A10
COL databkpsize FORMAT A10
COL ctlbkpsize FORMAT A10
COL tblspc FORMAT A12
BREAK ON input_type ON started_at ON duration ON output_size ON ctlbkpsize

SELECT a.input_type input_type,
       TO_CHAR(a.start_time, 'YYYYMMDD HH24:MI') AS started_at,
       a.time_taken_display AS duration,
       a.output_bytes_display AS  output_size,
       d.filesize_display AS ctlbkpsize,
       b.filesize_display AS archbkpsize,
       c.filesize_display AS databkpsize,
       c.tsname AS tblspc       
  FROM v$rman_backup_job_details a,
       v$backup_archivelog_details b,
       v$backup_datafile_details c,
       v$backup_controlfile_details d
  WHERE a.status='COMPLETED'
    AND a.end_time BETWEEN TRUNC(SYSDATE-7) AND TRUNC(SYSDATE)
    AND a.session_recid = b.session_recid (+)
    AND a.session_recid = c.session_recid (+)
    AND a.session_recid = d.session_recid (+);
    
CLEAR COLUMNS    
SPOOL OFF

