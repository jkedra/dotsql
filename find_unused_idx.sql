SET LINESIZE 160 PAGESIZE 50
SET VERIFY OFF
COL owner FORMAT A14
COL index_name FORMAT A30
COL index_type FORMAT a14
col table_name FORMAT A30

BREAK ON owner SKIP PAGE
COMPUTE COUNT LABEL "unused idxs" OF index_type ON owner

-- show objects touched by statistic job
SELECT a.owner, a.index_name, c.index_type, c.table_name,
       to_char(b.created, 'DD.MM.YYYY') created,
       to_char(b.last_ddl_time, 'DD.MM.YYYY') last_ddl,
       to_char(c.last_analyzed, 'DD.MM.YYYY') analyzed
    FROM (  SELECT owner, index_name FROM dba_indexes di
            WHERE di.index_type != 'LOB'
            AND owner NOT IN ('SYS', 'SYSMAN', 'SYSTEM',
                              'MDSYS', 'WMSYS', 'TSMSYS',
                               'DBSNMP', 'OUTLN', 'RMAN',
                               'OLAPSYS', 'CTXSYS')
            AND owner=NVL(UPPER('&owner'),owner)
            MINUS
            SELECT DISTINCT object_owner, object_name
            FROM dba_hist_sql_plan sp, dba_hist_sqlstat ss
            WHERE sp.sql_id=ss.sql_id AND sp.object_type LIKE '%INDEX%'
            AND (ss.action <>'GATHER_STATS_JOB' OR ss.action IS NULL)
            MINUS
            SELECT index_owner, index_name FROM dba_constraints dc
         ) a, dba_objects b, dba_indexes c
WHERE a.owner=b.owner AND a.owner=c.owner
  AND a.index_name=b.object_name AND a.index_name=c.index_name
  AND object_type='INDEX'
ORDER BY a.owner,a.index_name,created DESC;

CLEAR BREAKS

