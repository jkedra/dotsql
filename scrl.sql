set lines 100
col scrnam format a55
SELECT scrnam,impdat,version FROM adm_track
  WHERE scrnam LIKE 'load%'
   ORDER BY impdat ASC

/

