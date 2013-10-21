--
col status format a8
select process,pid,status,client_process,sequence# seq#,block#,blocks,delay_mins delay from v$managed_standby;
