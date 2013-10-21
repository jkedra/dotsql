--
-- luzne zapytania do automatic undo
--
SELECT END_TIME, ROUND((UNDOBLKS*8192)/1024/1024) SIZE_MB,  ROUND(maxquerylen/60,1) QUERYLEN_MAX, 
MAXCONCURRENCY AS "MAXCON", SSOLDERRCNT, NOSPACEERRCNT from v$undostat order by size_mb desc

select  round(sum(bytes)/1024/1024) MB  from DBA_UNDO_EXTENTS where status='UNEXPIRED'
