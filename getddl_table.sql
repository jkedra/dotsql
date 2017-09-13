-- http://laurentschneider.com/wordpress/2014/08/dbms_metadata-get_ddl-in-sqlplus.html
set long 1000000 
set longchunksize 32000 
set linesize 32000 
set trimspool on  
set heading off  
set pages 0  
set newpage none  
--set embedded on  
set tab off  
--set feedback off  
set echo off
--set sqlblanklines on
--set define off
--set sqlprefix off
--set blockterminator OFF

exec DBMS_METADATA.SET_TRANSFORM_PARAM(DBMS_METADATA.SESSION_TRANSFORM,'SQLTERMINATOR',true);

select dbms_metadata.get_ddl('TABLE', '&1') from dual;

