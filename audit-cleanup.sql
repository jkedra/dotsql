-- vim:ts=4
-- http://my8bites.blogspot.com/2013/09/oracle-11g-auditing.html
-- http://www.oracle.com/technetwork/issue-archive/2010/10-nov/o60security-176069.html
-- audit_trail_all
-- AUDIT_TRAIL_AUD_STD
-- audit_trail_db_std
-- 
SET SERVEROUTPUT ON
BEGIN
	IF
		SYS.DBMS_AUDIT_MGMT.IS_CLEANUP_INITIALIZED(
			SYS.DBMS_AUDIT_MGMT.audit_trail_all)
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

/*

begin
  dbms_audit_mgmt.clean_audit_trail(
     audit_trail_type        =>  dbms_audit_mgmt.audit_trail_all,
     use_last_arch_timestamp => TRUE
  );
end;
/


begin
   dbms_audit_mgmt.drop_purge_job ('audit_trail_purge_job');
end;
/


begin
   dbms_audit_mgmt.create_purge_job (
   audit_trail_type            => dbms_audit_mgmt.audit_trail_all,
   audit_trail_purge_interval  => 24,
   audit_trail_purge_name      => 'audit_trail_purge_job',
   use_last_arch_timestamp     => TRUE
   );
end;
/

begin
 sys.dbms_audit_mgmt.set_audit_trail_property(
  audit_trail_type            => sys.dbms_audit_mgmt.AUDIT_TRAIL_AUD_STD,
  audit_trail_property        => sys.dbms_audit_mgmt.db_delete_batch_size,
  audit_trail_property_value  => 100000);

 sys.dbms_audit_mgmt.set_audit_trail_property(
  audit_trail_type            => sys.dbms_audit_mgmt.AUDIT_TRAIL_FILES,
  audit_trail_property        => sys.dbms_audit_mgmt.OS_FILE_MAX_AGE,
  audit_trail_property_value  => 7);
end;
/


end;
/

BEGIN
DBMS_AUDIT_MGMT.INIT_CLEANUP(
              audit_trail_type => DBMS_AUDIT_MGMT.AUDIT_TRAIL_ALL,
      default_cleanup_interval => 24 ); -- hours
END;
/


select * from DBA_AUDIT_MGMT_CLEANUP_JOBS;

*/

