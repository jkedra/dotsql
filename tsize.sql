SET VERIFY OFF
COL idx FORMAT A31
SET TIMING ON

PROMPT table size only
SELECT ROUND(SUM(NVL(bytes,0))/1024/1024) "MB"
   FROM dba_segments
      WHERE owner=NVL(UPPER('&&owner'),user)
      AND segment_name=UPPER('&&table_name');

-- old:
/*
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
WHERE owner=NVL(UPPER('&&owner'),user)
	AND temporary='N'
	AND table_name=UPPER('&&table_name');
*/

-- new:
-- not nice but much, much faster
WITH segs AS (
   SELECT NVL(UPPER('&&owner'),user) owner, UPPER('&&table_name') name FROM dual
   UNION
   SELECT owner, segment_name name FROM dba_lobs
      WHERE owner=NVL(UPPER('&&owner'),user)
        AND table_name=UPPER('&&table_name')
   UNION
   SELECT owner, index_name name FROM dba_indexes
      WHERE owner=NVL(UPPER('&&owner'),user)
      AND table_name=UPPER('&&table_name')
)
SELECT table_name, (    SELECT ROUND(SUM(NVL(bytes,0))/1024/1024) "total MB"
                        FROM dba_segments ds, segs
                        WHERE ds.owner = segs.owner
                          AND ds.segment_name = segs.name
                  ) total_size_MB
FROM dba_tables dt
WHERE owner=NVL(UPPER('&&owner'),user)
	AND temporary='N'
	AND table_name=UPPER('&&table_name');


--
SELECT * FROM (
    SELECT table_name, dts.tablespace_name, (
                            SELECT ROUND(SUM(NVL(bytes,0))/1024/1024) "total MB"
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
                            AND tablespace_name=dts.tablespace_name
                      ) sizeInMB
    FROM dba_tables dt, dba_tablespaces dts
    WHERE  owner=NVL(UPPER('&&owner'), user)
            AND temporary='N'
            AND table_name=UPPER('&&table_name')
) WHERE sizeinmb IS NOT NULL;

BREAK ON REPORT
COMPUTE SUM LABEL "total in indexes" OF MB ON REPORT
SELECT s.segment_name idx,
       ROUND(SUM(s.bytes)/1024/1024) MB
    FROM dba_segments s, dba_indexes i
    WHERE s.owner = i.owner
      AND s.segment_name = i.index_name
      AND i.table_name = UPPER('&&table_name')
      AND i.owner = NVL(UPPER('&&owner'), user)
    GROUP BY s.segment_name;  
CLEAR BREAKS

SET VERIFY ON
