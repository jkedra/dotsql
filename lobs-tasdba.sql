SELECT SUM(gb), table_name FROM (
SELECT ROUND(sum(bytes)/1024/1024/1024,2) GB, l.table_name table_name, l.segment_name
FROM dba_lobs l, dba_segments s
WHERE l.owner='TASDBA' AND l.segment_name=s.segment_name
group by l.table_name, l.segment_name
)
WHERE gb>=1
GROUP BY table_name
ORDER by 1 desc;
