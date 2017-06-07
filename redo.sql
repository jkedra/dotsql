col member format a50
COL group#  FORMAT 99 HEADING "GRP"
COL thread# FORMAT 9  HEADING "T"
COL MB FORMAT 9999
COL status FORMAT A6
COL instance FORMAT A12
SET LINES 120

SELECT a.group#, a.thread#, t.instance,
       a.bytes/1024/1024 MB,
       a.archived, SUBSTR(a.status, 1, 6) status, b.member
    FROM v$log a, v$logfile b, v$thread t
        WHERE a.group#=b.group#
          AND a.thread#=t.thread#
        ORDER BY thread#,group#
/
