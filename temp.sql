col program format a20
col username format a10
col tablespace format a10
col osuser format a10

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
       , b.segfile#
       , b.segblk#
       , b.blocks;

CLEAR BREAKS
