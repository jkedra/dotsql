SET VERIFY OFF
SET LINESIZE 160 PAGESIZE 35
COL module format a30
COL action format a30

SELECT distinct TO_CHAR(timestamp, 'DD.MM.YYYY HH24:MI') time,
        module,action FROM WRH$_SQL_PLAN sp, WRH$_SQLSTAT ss
WHERE sp.object_name=UPPER('&object_name')
        AND sp.object_owner=NVL(UPPER('&owner'), sp.object_owner)
        AND sp.sql_id=ss.sql_id;

