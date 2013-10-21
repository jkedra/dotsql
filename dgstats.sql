
COLUMN name FORMAT   a25
COLUMN computed FORMAT   a16
COLUMN value  FORMAT   a16
COL    time FORMAT a16

SET LINESIZE 120

ALTER SESSION SET NLS_DATE_FORMAT='DD.MM.YY HH24:MI';


select NAME,VALUE, UNIT,substr(time_computed,1,16) computed, substr(datum_time,1,16) datum
from v$dataguard_stats;

