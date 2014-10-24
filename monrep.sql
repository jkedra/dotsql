
set trimspool on
set trim on
set pages 0
set long 10000000
set longchunksize 10000000
set linesize 200

ACCEPT sql_id   PROMPT 'sql_id   [adfasdf]: ' DEFAULT 'adfasdf'
PROMPT possible report types TEXT HTML ACTIVE
PROMPT ACTIVE requires Flash and active Internet connection
ACCEPT rep_type PROMPT 'report type [HTML]: ' DEFAULT 'HTML'
PROMPT sql_monitor_for_&sql_id..html
SET TERMOUT OFF
SPOOL sql_monitor_for_&sql_id..html


VARIABLE my_rept CLOB;

BEGIN
   :my_rept := dbms_sqltune.report_sql_monitor(sql_id => '&sql_id',
	report_level => 'ALL', type => '&rep_type'); 
END;
/ 

PRINT :my_rept

SPOOL off; 
SET TERMOUT ON
