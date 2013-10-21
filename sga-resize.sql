SET LINES 160
COL component FORMAT A20
SELECT start_time,inst_id,component, oper_type, oper_mode,
       initial_size/1024/1024 "INITIAL", TARGET_SIZE/1024/1024
       "TARGET", FINAL_SIZE/1024/1024 "FINAL", status from gv$sga_resize_ops
WHERE start_time > SYSDATE-7
/

