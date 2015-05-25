SELECT rownum,table_name,total_size_MB FROM (
SELECT table_name, (    SELECT ROUND(SUM(NVL(bytes,0))/1024/1024) "total MB"
                        FROM dba_segments
                        WHERE (owner,segment_name) IN (
                            SELECT dt.owner, dt.table_name FROM dual
                            UNION
                            SELECT owner,segment_name FROM dba_lobs
                            WHERE owner=dt.owner and table_name=dt.table_name
                            UNION
                            SELECT owner,index_name FROM dba_indexes
                            WHERE owner=dt.owner and table_name=dt.table_name
                        )
                  ) total_size_MB
FROM dba_tables dt WHERE owner='TASDBA' AND temporary='N'
ORDER BY 2 DESC NULLS LAST
) WHERE ROWNUM<11;

