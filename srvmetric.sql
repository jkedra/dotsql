-----
-----

SET PAGESIZE 50
SET LINESIZE 110

TTITLE 'Services Configured to Use Load Balancing Advisory (LBA) Features|(From DBA_SERVICES)'
COL name            FORMAT A16      HEADING 'Service Name' WRAP
COL created_on      FORMAT A20      HEADING 'Created On' WRAP
COL goal            FORMAT A12      HEADING 'Service|Workload|Management|Goal'
COL clb_goal        FORMAT A12      HEADING 'Connection|Load|Balancing|Goal'
COL aq_ha_notifications FORMAT A16  HEADING 'Advanced|Queueing|High-|Availability|Notification'

SELECT 
     name
    ,TO_CHAR(creation_date, 'mm-dd-yyyy hh24:mi:ss') created_on
    ,goal
    ,clb_goal
    ,aq_ha_notifications
  FROM dba_services
 WHERE goal IS NOT NULL
   AND name NOT LIKE 'SYS%'
 ORDER BY name
;
TTITLE OFF
/* 
|| Listing 6: Using the GV$SERVICEMETRIC global view to track how RAC
||	       services are responding to the Load Balancing Advisor
*/

TTITLE 'Current Service-Level Metrics|(From GV$SERVICEMETRIC)'
BREAK ON service_name NODUPLICATES
COL service_name    FORMAT A08          HEADING 'Service|Name' WRAP
COL inst_id         FORMAT 9999         HEADING 'Inst|ID'
COL beg_hist        FORMAT A10          HEADING 'Start Time' WRAP
COL end_hist        FORMAT A10          HEADING 'End Time' WRAP
COL intsize_csec    FORMAT 9999         HEADING 'Intvl|Size|(cs)'
COL goodness        FORMAT 999999       HEADING 'Good|ness'
COL delta           FORMAT 999999       HEADING 'Pred-|icted|Good-|ness|Incr'
COL cpupercall      FORMAT 99999999     HEADING 'CPU|Time|Per|Call|(mus)'
COL dbtimepercall   FORMAT 99999999     HEADING 'Elpsd|Time|Per|Call|(mus)'
COL callspersec     FORMAT 99999999     HEADING '# 0f|User|Calls|Per|Second'
COL dbtimepersec    FORMAT 99999999     HEADING 'DBTime|Per|Second'
COL flags           FORMAT 999999       HEADING 'Flags'
SELECT
     service_name
    ,TO_CHAR(begin_time,'hh24:mi:ss') beg_hist
    ,TO_CHAR(end_time,'hh24:mi:ss') end_hist
    ,inst_id
    ,goodness
    ,delta
    ,flags
    ,cpupercall
    ,dbtimepercall
    ,callspersec
    ,dbtimepersec
  FROM gv$servicemetric
 ORDER BY service_name, begin_time DESC, inst_id
;
CLEAR BREAKS
TTITLE OFF


