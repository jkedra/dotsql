col member format a50
COL group#  FORMAT 99 HEADING "GRP"
COL thread# FORMAT 9  HEADING "T"
COL MB FORMAT 99999
COL status FORMAT A10

SELECT a.group#, a.thread#, a.bytes/1024/1024 MB,a.archived,a.status,b.member
FROM v$log a, v$logfile b
WHERE a.group#=b.group#
ORDER BY group#,thread#

/
