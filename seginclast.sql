COL owner FORMAT A16
COL object FORMAT A30
SET VERIFY OFF
PROMPT Shows 10 most increasing segments
PROMPT in last week (default, or days specified)
PROMPT DEFAULTS
PROMPT days 7
PROMPT objects 30




SELECT * FROM (
SELECT o.owner,o.object_name object,
       ROUND(sum(ss.space_used_delta)/1024/1024, 3) space_delta_mb
    FROM dba_hist_seg_stat ss, dba_hist_snapshot hs, dba_objects o
    WHERE hs.instance_number = 1
      AND ss.obj#=o.object_id
      AND ss.snap_id = hs.snap_id
      AND o.owner NOT IN ('SYS')      
      AND hs.begin_interval_time < SYSDATE
      AND hs.end_interval_time > SYSDATE - NVL(&past_days, 7)
    GROUP BY o.owner,o.object_name
    ORDER BY 3 DESC
) WHERE ROWNUM < NVL('&top_objects', 30) +1;

