--vim:ts=4:expandtab
-- user_tab_stat_prefs
-- dba_tab_stat_prefs

SET SERVEROUTPUT ON SIZE 20000

PROMPT USER STATS
PROMPT ----------

DECLARE
	TYPE	string_type IS TABLE OF VARCHAR2(32);
    params	string_type;
	value	VARCHAR2(32);
BEGIN
	params := string_type('AUTOSTATS_TARGET','CASCADE','DEGREE','ESTIMATE_PERCENT','METHOD_OPT',
                     'NO_INVALIDATE','GRANULARITY','PUBLISH','INCREMENTAL','STALE_PERCENT');
	FOR i IN params.FIRST .. params.LAST
	LOOP
		SELECT DBMS_STATS.GET_PREFS(params(i)) INTO value FROM DUAL;
		DBMS_OUTPUT.PUT_LINE( RPAD(params(i), 18) ||' := '||value);
	END LOOP;

END;
/

