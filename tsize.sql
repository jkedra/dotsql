SET VERIFY OFF

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
FROM dba_tables dt
WHERE owner=NVL(UPPER('&owner'),user)
	AND temporary='N'
	AND table_name=UPPER('&table_name');
