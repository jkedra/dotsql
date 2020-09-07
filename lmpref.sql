col value format a20
col preference format a30
SET VERIFY OFF
select PREFERENCE,VALUE FROM lps_static.LPS_PREFERENCE_ADDED where preference LIKE '%&1%';
