col name		format	a40
col member		format	a40
col user_name		format	a10
col audit_option	format	a16
col proxy_name		format	a7

col grantee format a10
col owner format a10
col table_name format a20
col grantor format a10
col privilege format a20


define _EDITOR=vim
set termout off

set PAGESIZE 999
set LINESIZE 80
set SERVEROUTPUT ON size 1000000
-- obcinanie koncowek linii (zamiast full linesize)
set TRIMSPOOL ON
set LONG 5000

--col name new_value gname
--select user || '@' || 
--	DECODE(name,
--			'PROD2.BD.ONET.PL',	'PROD2',
--			'PROD5.BD.ONET.PL',	'PROD5',
--			'DEV.BD.ONET.PL',	'DEV',
--			'PROD.BD.ONET.PL',	'PROD',
--			'ADS2.BD.ONET.PL',	'ADS2',
--			'TEST2.BD.ONET.PL',	'TEST2',
--			'WH.LISTEK.ONET',	'WH',
--			'STG.LISTEK.ONET',	'STG',
--		name)
--	 || '> ' name from V$DATABASE;

-- nowy prompt na podstawie pomyslu T.Kyte
-- "Expert Oracle - Database Architecture"

define gname=idle
column global_name new_value gname
/*
select user||'@'|| substr(global_name,1,
	-- jezeli INSTR nie znajdzie "." (dot=0) to substr nie obcina - pelna dlugosc
	-- jezeli INSTR znajdzie kropke, obetnij string przed nia
	decode(dot, 0, length(global_name), dot-1) ) global_name
	from (select global_name, instr(global_name,'.') dot from global_name);
*/

/*
SELECT USER||'@'|| SUBSTR(instance_name,1,
	-- jezeli INSTR nie znajdzie "." (dot=0)
    -- to substr nie obcina - pelna dlugosc
	-- jezeli INSTR znajdzie kropke, obetnij string przed nia
	DECODE(dot, 0, LENGTH(instance_name), dot-1) ) global_name
FROM (
    SELECT instance_name, INSTR(instance_name,'.') dot FROM v$instance
);
*/

SELECT USER||'@'||SYS_CONTEXT('USERENV','DB_NAME')
       ||'['||SUBSTR(instance_name,1,
                    DECODE(dot,
                        0, LENGTH(instance_name),
                        dot-1
                    )
              )||']' global_name
FROM (SELECT instance_name, INSTR(instance_name,'.') dot FROM v$instance);




set SQLPROMPT '&&gname> '

alter session set nls_date_format='DD.MM.YY HH24:MI:SS';

set termout on

