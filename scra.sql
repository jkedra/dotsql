SET lines 100
COL scrnam format a55

SELECT scrnam,impdat,version FROM adm_track
	WHERE impdat > SYSDATE-360
	ORDER BY impdat ASC
/

