

PROMPT hit ratio
SELECT namespace,
        ROUND( sum(pins) / (sum(pins) + sum(reloads)) * 100,2)
        "reload",
        ROUND( sum(pins) / (sum(pins) + sum(invalidations)) * 100,2)
        "invalidation"
FROM v$librarycache
WHERE pins > 0
GROUP BY namespace
/

SELECT namespace, pins, pinhits, reloads, invalidations
  FROM V$LIBRARYCACHE
  WHERE pins > 0
 ORDER BY namespace
/

PROMPT fmo LC_INUSE_MEMORY_OBJECTS
PROMPT ims LC_INUSE_MEMORY_SIZE
PROMPT fmo LC_FREEABLE_MEMORY_OBJECTS
PROMPT fms LC_FREEABLE_MEMORY_SIZE
PROMPT ==============================

SELECT LC_NAMESPACE namespace,
	LC_INUSE_MEMORY_OBJECTS     imo,
	LC_INUSE_MEMORY_SIZE        ims,
	LC_FREEABLE_MEMORY_OBJECTS  fmo,
	LC_FREEABLE_MEMORY_SIZE     fms
FROM V$LIBRARY_CACHE_MEMORY;

PROMPT =================================================
PROMPT you may find rowcache.sql also being interesting
PROMPT =================================================
