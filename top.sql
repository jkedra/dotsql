
PROMPT 
PROMPT I = inst_id
PROMPT ELAP_TIME = elapsed_time [seconds]
PROMPT CPU_TIME = in seconds
PROMPT CONCTIME = concurency_wait_time [seconds]
PROMPT CLUSTIME = cluser_wait_time [seconds]
PROMPT UIOWTIME = user_io_wait_time [seconds]
PROMPT
col minutes_elapsed     HEADING "Minutes|Elapsed"
COL sql_text FORMAT A40 HEADING "SQL TEXT" word_wrapped

SET NUMWIDTH 9 

COL i FORMAT 9

SELECT inst_id I,
       sql_id,
       SUBSTR (sql_text, 1, 100) sql_text,
       ROUND(elapsed_time/1000000) elap_time,
       ROUND(cpu_time/1000000) cpu_time,
       ROUND(concurrency_wait_time/1000000) conctime,
       ROUND(cluster_wait_time/1000000) clustime,
       ROUND(user_io_wait_time/1000000) uiowtime,
       ROUND(physical_read_bytes/1000000) phys_read_mb,
       px_server#
  FROM gv$sql_monitor
 WHERE status = 'EXECUTING' AND elapsed_time > 0;
