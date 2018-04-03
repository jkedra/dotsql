col sidser format a10
col username format a20
col machine format A10
COL process FORMAT A8
COL osuser FORMAT A10
COL program FORMAT A10
COL inst_id FORMAT 99 HEADING 'i'
SET LINES 120

SELECT username,status,inst_id, sid||','||serial# sidser,
	SUBSTR(machine,1,10) machine, process, program, osuser,
    TO_CHAR(logon_time, 'DDMMYY.HHMM') logon
FROM gv$session
WHERE username='&username'
/

