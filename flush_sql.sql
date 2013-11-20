set serveroutput on
set pagesize 9999
set linesize 155
var name varchar2(50)

REM 11g, in 10g will work only if previoulsy you 
REM alter session set events '5614566 trace name context forever';
REM Bug: Bug 5614566

accept sql_id -
       prompt 'Enter value for sql_id: '

BEGIN

select address||','||hash_value into :name
from v$sqlarea
where sql_id like '&&sql_id';

dbms_shared_pool.purge(:name,'C',1);

END;
/

undef sql_id
undef name

