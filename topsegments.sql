COL segment_name FORMAT A30

SELECT segment_name, ROUND(bytes/1024/1024/1024, 2) GB 
FROM (
SELECT rownum,segment_name, bytes FROM dba_segments
    WHERE tablespace_name='SYSAUX'
    ORDER BY BYTES DESC
)
WHERE ROWNUM <21;

