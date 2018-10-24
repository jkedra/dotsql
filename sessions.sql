col sidser format a10
col username format a12
col machine format A10

COL process FORMAT A15
COL osuser FORMAT A10
COL program FORMAT A16

COL status FORMAT A1
COL inst_id FORMAT 9 HEADING 'i'
SET LINES 120

PROMPT STATUS
PROMPT A = ACTIVE
PROMPT I = INACTIVE
PROMPT K = KILLED
PROMPT S = SNIPED

SELECT username,
    DECODE(status, 'ACTIVE', 'A',
                   'INACTIVE', 'I',
                   'KILLED', 'K',
                   'SNIPED', 'S', status) status,
                     inst_id, sid||','||serial# sidser,
	SUBSTR(machine,-10) machine, process,
    SUBSTR(program,1,15) program,  osuser,
    TO_CHAR(logon_time, 'DDMMYY.HHMI') logon
FROM gv$session
WHERE username IS NOT NULL
    AND username NOT IN ('SYS', 'DBSNMP')
/

