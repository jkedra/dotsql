/*
OEMDEFAULT@ADAANFP2> desc dba_registry;    
 Name					   Null?    Type
 ----------------------------------------- -------- ----------------------------
 COMP_ID				   NOT NULL VARCHAR2(30)
 COMP_NAME					    VARCHAR2(255)
 VERSION					    VARCHAR2(30)
 STATUS 					    VARCHAR2(44)
 MODIFIED					    VARCHAR2(29)
 NAMESPACE				   NOT NULL VARCHAR2(30)
 CONTROL				   NOT NULL VARCHAR2(30)
 SCHEMA 				   NOT NULL VARCHAR2(30)
 PROCEDURE					    VARCHAR2(61)
 STARTUP					    VARCHAR2(8)
 PARENT_ID					    VARCHAR2(30)
 OTHER_SCHEMAS					    VARCHAR2(4000)
*/

SET LINES 120
COL comp_NAME FORMAT A50
COL VERSION FORMAT A20
COL STATUS FORMAT A20
SELECT comp_name,version,status FROM dba_registry;

