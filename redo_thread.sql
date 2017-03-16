
COL instance FORMAT A20
SET NUMWIDTH 3

SELECT instance, thread# t#, status, enabled, groups grps
    FROM v$thread;

SET NUMWIDTH 8
