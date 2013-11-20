-- vim:ts=4
SET SERVEROUTPUT ON
BEGIN
	IF
		SYS.DBMS_AUDIT_MGMT.IS_CLEANUP_INITIALIZED(
			SYS.DBMS_AUDIT_MGMT.AUDIT_TRAIL_AUD_STD)
	THEN
		DBMS_OUTPUT.PUT_LINE('AUD$ is initialized for cleanup');
	ELSE
		DBMS_OUTPUT.PUT_LINE('AUD$ is not initialized for cleanup.');
	END IF;
END;
/


COL parameter_name format A40
col parameter_value format a30
SET LINES 160
SELECT * FROM DBA_AUDIT_MGMT_CONFIG_PARAMS;

