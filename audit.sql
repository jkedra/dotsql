
/*
   zeby ten skrypt mial sens, audit musi byc wlaczony oraz
   wygladac nastepujaco:

   SYS@PROD2> select * from dba_stmt_audit_opts;
   USER_NAME  PROXY_N AUDIT_OPTION         SUCCESS    FAILURE
   ---------- ------- -------------------- ---------- ----------
   [...]
                      ALTER USER           BY ACCESS  BY ACCESS
                      SYSTEM GRANT         BY ACCESS  BY ACCESS
                      CREATE USER          BY ACCESS  BY ACCESS
   [...]

   SYS@PROD2> audit alter user by access;
   
*/

REM SYS@PROD2> desc dba_audit_trail
REM  Name                                      Null?    Type
REM  ----------------------------------------- -------- ----------------------------
REM  OS_USERNAME                                        VARCHAR2(255)
REM  USERNAME                                           VARCHAR2(30)
REM  USERHOST                                           VARCHAR2(128)
REM  TERMINAL                                           VARCHAR2(255)
REM  TIMESTAMP                                 NOT NULL DATE
REM  OWNER                                              VARCHAR2(30)
REM  OBJ_NAME                                           VARCHAR2(128)
REM  ACTION                                    NOT NULL NUMBER
REM  ACTION_NAME                                        VARCHAR2(27)
REM  NEW_OWNER                                          VARCHAR2(30)
REM  NEW_NAME                                           VARCHAR2(128)
REM  OBJ_PRIVILEGE                                      VARCHAR2(16)
REM  SYS_PRIVILEGE                                      VARCHAR2(40)
REM  ADMIN_OPTION                                       VARCHAR2(1)
REM  GRANTEE                                            VARCHAR2(30)
REM  AUDIT_OPTION                                       VARCHAR2(40)
REM  SES_ACTIONS                                        VARCHAR2(19)
REM  LOGOFF_TIME                                        DATE
REM  LOGOFF_LREAD                                       NUMBER
REM  LOGOFF_PREAD                                       NUMBER
REM  LOGOFF_LWRITE                                      NUMBER
REM  LOGOFF_DLOCK                                       VARCHAR2(40)
REM  COMMENT_TEXT                                       VARCHAR2(4000)
REM  SESSIONID                                 NOT NULL NUMBER
REM  ENTRYID                                   NOT NULL NUMBER
REM  STATEMENTID                               NOT NULL NUMBER
REM  RETURNCODE                                NOT NULL NUMBER
REM  PRIV_USED                                          VARCHAR2(40)
REM 
REM SYS@PROD2> @audit

TTITLE OFF
SET FEEDBACK OFF
COL USERNAME	FORMAT A10
COL WHERE	FORMAT A20
COL TYPE        FORMAT A10 WORD_WRAPPED
COL OBJ_NAME	FORMAT A10
COL ACTION_NAME	FORMAT A10
COL PRIV_USED	FORMAT A10

SET TERMOUT OFF
ALTER SESSION SET NLS_DATE_FORMAT='HH24:MI DD.MM';
SET TERMOUT ON

PROMPT
PROMPT Pokazuje wszystkie udane komendy ALTER USER
PROMPT UWAGA! SYS NIE MOZE BYC AUDYTOWANY!

SELECT	username, os_username||'@'||terminal as "WHERE", obj_name,
	timestamp, priv_used
FROM dba_audit_trail
WHERE action=43 AND returncode=0
ORDER BY timestamp
/

COL PRIV_USED CLEAR
COL ACTION_NAME CLEAR
COL OBJ_NAME CLEAR
SET FEEDBACK ON
PROMPT
