set trimspool on
set trim on
set pages 0
set long 10000000
set longchunksize 10000000
set linesize 200

ACCEPT sql_id   PROMPT 'sql_id   [adfasdf]: ' DEFAULT 'adfasdf'
PROMPT possible report types XML ACTIVE
PROMPT ACTIVE requires Flash and active Internet connection
PROMPT
ACCEPT rep_type PROMPT 'report type [ACTIVE]: ' DEFAULT 'ACTIVE'
PROMPT
PROMPT /tmp/sql_detail_for_&sql_id..html
PROMPT

SET TERMOUT OFF
SPOOL /tmp/sql_detail_for_&sql_id..html


VARIABLE my_rept CLOB;

BEGIN
   :my_rept := DBMS_SQLTUNE.report_sql_detail(
	sql_id => '&sql_id',
	report_level => 'ALL',
	type => '&rep_type'); 
END;
/ 

PRINT :my_rept

SPOOL off; 
SET TERMOUT ON

/*
report level:
Level of detail for the report, either 'BASIC', 'TYPICAL' or 'ALL'. Default assumes 'TYPICAL'. Their meanings are explained below.

In addition, individual report sections can also be enabled or disabled by using a +/- section_name. Several sections are defined:

    'TOP'- Show top values for the ASH dimensions for a SQL statement; ON by default
    'SPM'- Show existing plan baselines for a SQL statement; OFF by default
    'MISMATCH'- Show reasons for creating new child cursors (sharing criteria violations); OFF by default.
    'STATS'- Show SQL execution statistics per plan from GV$SQLAREA_PLAN_HASH; ON by default
    'ACTIVITY' - Show top activity from ASH for each plan of a SQL statement; ON by default
    'ACTIVITY_ALL' - Show top activity from ASH for each line of the plan for a SQL statement; OFF by default
    'HISTOGRAM' - Show activity histogram for each plan of a SQL statement (plan timeline histogram); ON by default
    'SESSIONS' - Show activity for top sessions for each plan of a SQL statement; OFF by default
    'MONITOR' - Show show one monitored SQL execution per execution plan; ON by default
    'XPLAN' - Show execution plans; ON by default
    'BINDS' - show captured bind data; ON by default

In addition, SQL text can be specified at different levels:

    -SQL_TEXT - No SQL text in report
    +SQL_TEXT - OK with partial SQL text up to the first 2000 chars as stored in GV$SQL_MONITOR
    -SQL_FULLTEXT - No full SQL text (+SQL_TEXT)
    +SQL_FULLTEXT - Show full SQL text (default value)

The meanings of the three top-level report levels are:

    NONE - minimum possible
    BASIC - SQL_TEXT+STATS+ACTIVITY+HISTOGRAM
    TYPICAL - SQL_FULLTEXT+TOP+STATS+ACTIVITY+HISTOGRAM+XPLAN+MONITOR
    ALL - everything

*/
