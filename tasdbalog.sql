set linesize 120
col DD_HH24MISSFF format a18
col name format a20
col info format a60 word_wrapped
alter session set nls_timestamp_format='DD HH24:MI:SS.FF';


select * FROM (
select logdate DD_HH24MISSFF,name,flag,info from tasdba.adm_log
order by logdate desc
) WHERE ROWNUM < 100
/


