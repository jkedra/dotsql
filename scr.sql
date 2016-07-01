SET lines 100
COL scrnam format a55

SELECT a.scrnam, a.impdat, a.version
   FROM adm_track a, (
			SELECT scrnam, MAX(impdat) impdat
			  FROM adm_track
	                    GROUP BY scrnam
		      ) b
	WHERE a.impdat > SYSDATE - 360
          AND a.scrnam = b.scrnam
          AND a.impdat = b.impdat
	ORDER BY impdat
/

