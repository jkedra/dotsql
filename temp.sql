col program format a30
col username format a10
col tablespace format a10
col osuser format a10
COL SID FORMAT 9999
COL SIZE_MB FORMAT 9999999

SET LINES 160

BREAK ON REPORT
COMPUTE SUM LABEL "total MB" OF size_mb ON REPORT

SELECT   b.TABLESPACE
       , b.segfile#
       , b.segblk#
       , ROUND (  (  ( b.blocks * p.VALUE ) / 1024 / 1024 ), 2 ) size_mb
       , a.SID
       , a.serial#
       , a.username
       , a.osuser
       , a.program
       , a.status
    FROM v$session a
       , v$sort_usage b
       , v$process c
       , v$parameter p
   WHERE p.NAME = 'db_block_size'
     AND a.saddr = b.session_addr
     AND a.paddr = c.addr
ORDER BY b.TABLESPACE
       , b.blocks DESC
       , b.segfile#
       , b.segblk#;


COL tablespace_name FORMAT A20
SELECT inst_id, tablespace_name, total_blocks, used_blocks, free_blocks
    FROM gv$sort_segment;

CLEAR BREAKS
