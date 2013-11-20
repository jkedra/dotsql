col index_name format A15
col partition_name format A15
col tablespace_name format A15

select index_name,ip.partition_name,ip.tablespace_name,
        ROUND(bytes/1024/1024,1) MB
FROM user_ind_partitions ip, user_segments s
WHERE index_name=segment_name
        AND ip.partition_name=s.partition_name
/

