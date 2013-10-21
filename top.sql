
col minutes_elapsed     HEADING "Minutes|Elapsed"

COL sql_text FORMAT A40 HEADING "SQL TEXT" word_wrapped


SELECT inst_id inst,
       sql_id,
       SUBSTR (sql_text, 1, 100) sql_text,
       elapsed_time,
       cpu_time,
       concurrency_wait_time,
       cluster_wait_Time,
       user_io_wait_time,
       physical_read_bytes,
       px_server#
  FROM gv$sql_monitor
 WHERE status = 'EXECUTING' AND elapsed_time > 0;
