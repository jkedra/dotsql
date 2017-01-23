ACCEPT vtabsp CHAR  PROMPT  "tablespace name (% allowed):"

COL owner FORMAT A15
COL segment_name FORMAT A30
COL segment_type FORMAT A12

SET LINES 120

SELECT * FROM (
  SELECT owner,segment_type,segment_name,ROUND(SUM(bytes)/1024/1024,1) MB
    FROM dba_segments
    WHERE tablespace_name LIKE '&vtabsp'
    GROUP BY owner,segment_type,segment_name
    ORDER BY mb DESC
) WHERE rownum <11
ORDER BY mb DESC;

