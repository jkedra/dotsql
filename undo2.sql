-- (c) Jerzy Kedra 2009
-- some statistics from undo

SET LINESIZE 120
COL USERNAME FORMAT A8
COL SIDSER FORMAT A15
COL NAME FORMAT A8
PROMPT TRANSACTIONS PICTURE

SELECT  ss.username, ss.sid||'.'||serial# sidser,
        ss.status sess_stat, t.status TRANS_STAT,t.start_date, t.ptx, t.name,
        ROUND(t.USED_UBLK * (select max(block_size) from dba_tablespaces 
                    WHERE contents='UNDO') /1024/1024) UNDO_MB,
        t.cr_get,t.cr_change
FROM v$transaction t, v$rollstat rs, v$rollname rn, v$session ss
WHERE t.xidusn=rs.usn AND rn.usn = rs.usn AND ss.SADDR=t.SES_ADDR;  

PROMPT UNDO EXTENTS PICTURE

SELECT DISTINCT STATUS, ROUND(SUM(BYTES)/1024/1024) MB, COUNT(*) extents 
   FROM DBA_UNDO_EXTENTS GROUP BY STATUS;  
   
PROMPT UNDO STAT
SELECT * FROM (
SELECT to_char(begin_time,'DD.MM HH24:MI')||'-'||to_char(end_time, 'HH24:MI') date_range,
	undoblks,txncount,maxquerylen,maxqueryid,SSOLDERRCNT SSOLD,NOSPACEERRCNT NOSPACE,
	ACTIVEBLKS,TUNED_UNDORETENTION undret FROM v$undostat
)
WHERE rownum <30;

