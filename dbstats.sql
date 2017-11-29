

COL owner FORMAT A10
COL segment_type FORMAT A20

BREAK ON owner SKIP 1
COMPUTE SUM LABEL "total data" OF GB ON owner

SELECT owner,segment_type, ROUND(SUM(bytes)/1024/1024/1024,1) GB
FROM dba_segments
  WHERE NOT REGEXP_LIKE(owner,
        '^(APEX|CTXSYS|DBSNMP|EXFSYS|GGER|MD|OLAP|ORD|OUTLN|SYS|XDB|WMSYS)')
    AND NOT REGEXP_LIKE(segment_type, 'INDEX')
GROUP BY owner,segment_type
ORDER BY owner, GB DESC;

CLEAR BREAKS

---

SELECT segment_type, ROUND(SUM(bytes)/1024/1024/1024,1) GB
    FROM dba_segments
        WHERE owner='TASDBA'
            AND NOT REGEXP_LIKE(segment_type, 'INDEX')
GROUP BY segment_type;


BREAK ON data_type SKIP 1
COMPUTE SUM OF GB ON data_type

SELECT data_type, segment_type, ROUND(SUM(bytes)/1024/1024/1024) GB
FROM(
SELECT CASE
        WHEN REGEXP_LIKE(segment_name, '^ARCH_') THEN 'ARCH'
        ELSE 'REGULAR'
       END data_type,
       segment_type, bytes
    FROM dba_segments
        WHERE owner='TASDBA' AND NOT REGEXP_LIKE(segment_type, 'INDEX')
)
GROUP BY data_type, segment_type
ORDER BY data_type,segment_type;
        
CLEAR BREAKS    


COL table_name FORMAT A20
COL column_name FORMAT A20
COL segment_name FORMAT A20

PROMPT LOB DATA

SELECT l.table_name, l.column_name, ROUND(SUM(s.bytes)/1024/1024/1024) GB
FROM dba_segments s, dba_lobs l
WHERE s.owner='TASDBA'
  AND s.owner=l.owner
  AND s.segment_name=l.segment_name
  AND NOT REGEXP_LIKE(s.segment_type, 'INDEX')
  AND REGEXP_LIKE(s.segment_type, 'LOB')
GROUP BY l.table_name, l.column_name
HAVING ROUND(SUM(s.bytes)/1024/1024/1024) >= 1
ORDER BY GB DESC, table_name;


PROMPT tasr_fltexplog stats

/*
SELECT TO_CHAR(flt_dt, 'MM.YYYY'), rws FROM (
    SELECT TRUNC(flt_dt, 'MON') flt_dt, count(*) rws FROM tasr_fltexplog
    GROUP by TRUNC(flt_dt, 'MON') ORDER BY 1
);
*/

SELECT TO_CHAR(flt_dt, 'YYYY') year, TO_CHAR(rws, '999G999G999G999') rws FROM (
    SELECT TRUNC(flt_dt, 'YY') flt_dt, count(*) rws FROM tasr_fltexplog
    GROUP by TRUNC(flt_dt, 'YY') ORDER BY 1
);




