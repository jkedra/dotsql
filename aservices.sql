
COL network_name FORMAT A20
COL host_name    FORMAT A16
COL instance     FORMAT A30
SELECT vi.instance_name||'('||vi.host_name||')' instance,
	vas.network_name, vas.goal, vas.blocked
  FROM gv$active_services vas, gv$instance vi
    WHERE vas.network_name IS NOT NULL
          AND vi.inst_id=vas.inst_id
    ORDER BY service_id,vas.inst_id;
