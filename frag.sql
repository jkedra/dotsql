COL segment_name FORMAT A30

-- this query shows to large fragmentation due too many extents per object
--
SELECT segment_name,segment_type,extents,ROUND(bytes/1024/1024/1024,2) GB
FROM dba_segments
WHERE extents > 1000
ORDER BY extents DESC;

