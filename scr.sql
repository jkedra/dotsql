set lines 100
col scrnam format a55
select scrnam,impdat,version from adm_track order by impdat asc
/

