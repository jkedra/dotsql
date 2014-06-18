-- execute DBMS_STATS.GATHER_SYSTEM_STATS()
-- CPUSPEEDNW, IOSEEKTIM, IOTFRSPEED - gathered at startup (nonworkload)
-- MAXTHR, CPUSPEED - not gathered at all (nonworkload)
-- others are workload parameters
--
-- workload stats:
-- DBMS_STATS.GATHER_SYSTEM_STATS('interval', interval=>N)
-- where N is the number of minutes when statistics gathering is stopped automatically.

SELECT pname, pval1
FROM sys.aux_stats$
WHERE sname = 'SYSSTATS_MAIN';

