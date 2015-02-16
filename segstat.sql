SET LINES 120
col id FORMAT 09
col type format A20
col tblspc FORMAT A16
col stname FORMAT A20
col object format A45
SELECT ROWNUM id, object, type, tblspc, stname, value FROM (
    SELECT rownum, owner||'.'||object_name||
           NVL2(subobject_name, ' PART('||subobject_name||')', '') object,
           object_type type, tablespace_name tblspc, statistic_name stname,
           value
    FROM V$SEGMENT_STATISTICS
    WHERE statistic# IN (16,1) ORDER BY VALUE DESC
) WHERE rownum <= 10;

