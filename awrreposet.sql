-- https://docs.oracle.com/database/121/ARPLS/d_workload_repos.htm#ARPLS69140
-- interval in minutes
-- retention in minutes

-- retention to 20 days

BEGIN
  DBMS_WORKLOAD_REPOSITORY.MODIFY_SNAPSHOT_SETTINGS(
	retention => (60*24)*20, 
        interval => 10 );
END;
/
