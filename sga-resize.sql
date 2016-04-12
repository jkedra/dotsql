SET LINES 160
COL component FORMAT A25

PROMPT By default last 7 days are displayed.
ACCEPT vdays CHAR DEFAULT 7 PROMPT "days [7]: "

SELECT start_time,inst_id,component, oper_type, oper_mode,
       initial_size/1024/1024 "INITIAL", TARGET_SIZE/1024/1024
       "TARGET", FINAL_SIZE/1024/1024 "FINAL", status from gv$sga_resize_ops
WHERE start_time > SYSDATE-NVL(&vdays, 7)
/

SELECT component, max(TARGET_SIZE/1024/1024) "MAXSIZE",
       min(TARGET_SIZE/1024/1024) "MINSIZE",count(*) "OPERS"
FROM gv$sga_resize_ops
WHERE start_time > SYSDATE-NVL(&vdays, 7)
GROUP BY component
/


