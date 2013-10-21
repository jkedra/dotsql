
COL USERID      FORMAT A15
COL TERMINAL    FORMAT A10
COL TIMESTAMP   FORMAT A14
TTITLE SKIP 2 CENTER "UNSUCCESSFUL LOGONS" SKIP 2

SELECT  userid,timestamp#,terminal,returncode
FROM    sys.aud$
WHERE   action#=100 and returncode<>0 and sysdate-timestamp#<3
ORDER BY timestamp# desc
/
