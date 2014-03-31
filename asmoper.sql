SET LINES 160
COL error_code FORMAT A30
COL pwr FORMAT A6
COL name FORMAT A10
COL mins HEADING "Estm|mnts" FORMAT 9999

-- GROUP_NUMBER OPERA STAT      POWER     ACTUAL   SOFAR   EST_WORK   EST_RATE EST_MINUTES ERROR_CODE
-- ------------ ----- ---- ---------- ---------- ---------- ---------- ---------- ----------- ------------------------------
           1     REBAL RUN     1            1      13431      16977       3038           1

SELECT o.group_number||':'||dg.name name,
	o.operation, o.state stat, o.power||'/'||o.actual pwr,
        o.sofar,o.est_work,o.est_rate rate,o.est_minutes mins,o.error_code
FROM v$asm_operation o, v$asm_diskgroup dg
WHERE o.group_number=dg.group_number;

