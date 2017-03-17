
COL instance FORMAT A16
COL t# FORMAT 99
COL grps FORMAT 9999

SELECT instance, thread# t#,
       status, enabled, groups grps
    FROM v$thread;

