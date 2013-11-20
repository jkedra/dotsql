--
-- do sledzenia przydzielanych przywilei
-- wymaga wlaczonego audytu oraz
-- audit system grant by access
--
col username	format a15 word_wrapped
col grantee	format a15
col os		format a16
col obj_name	format a20
col priv_used	format a10 word_wrapped
col name	format a10 word_wrapped

SET TERMOUT OFF
ALTER SESSION SET NLS_DATE_FORMAT='DD.MM';
SET TERMOUT ON

TTITLE SKIP 2 CENTER "SYSTEM GRANT" SKIP 2
SELECT	timestamp "DATE", at.username ||decode(grantee, '', '', ' -> '||grantee) username,
	os_username||'@'||terminal as os, obj_name,
	priv_used, aa.name
FROM dba_audit_trail at, audit_actions aa
WHERE aa.action=at.action and returncode=0 and at.action not in (100, 101, 102, 103)
ORDER BY timestamp
/

TTITLE OFF
