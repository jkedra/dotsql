SET LINESIZE 100
COLUMN start_time FORMAT A20
COLUMN end_time FORMAT A20

SELECT TO_CHAR(start_time, 'DD-MON-YYY HH24:MI:SS') AS start_time,
       TO_CHAR(end_time, 'DD-MON-YYY HH24:MI:SS') AS end_time,
       max_iops,
       max_mbps,
       max_pmbps,
       latency,
       num_physical_disks AS disks
FROM   dba_rsrc_io_calibrate;

COLUMN calibration_time FORMAT a30
SELECT * FROM V$IO_CALIBRATION_STATUS;
