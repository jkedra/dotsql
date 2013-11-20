set echo off
set verify off

col A NOPRINT NEW_VALUE USERNAME
select decode(user,'APPDBA','TASDBA',
			'TASGEN','TASDBA',
	user) A from dual;

accept OWNER PROMPT 'OWNER [&USERNAME]: ' DEFAULT &USERNAME
accept VTABLE PROMPT 'TABLE: '

select tablespace_name,last_analyzed,blocks
from all_tables
where owner='&OWNER' and table_name='&VTABLE';

col grantee format a14
col grantor format a10

-- PRIV
select grantee,grantor,privilege,grantable
from all_tab_privs where table_schema='&OWNER'
and table_name='&VTABLE';


COL search_condition format a30
-- CONSTR
select constraint_name,constraint_type,search_condition
from all_constraints
where owner='&OWNER' and table_name='&VTABLE';

 ----------------------------------------- -------- ----------------------------
-- OWNER                                     NOT NULL VARCHAR2(30)
-- TABLE_NAME                                NOT NULL VARCHAR2(30)
-- TABLESPACE_NAME                                    VARCHAR2(30)
-- CLUSTER_NAME                                       VARCHAR2(30)
-- IOT_NAME                                           VARCHAR2(30)
-- PCT_FREE                                           NUMBER
-- PCT_USED                                           NUMBER
-- INI_TRANS                                          NUMBER
-- MAX_TRANS                                          NUMBER
-- INITIAL_EXTENT                                     NUMBER
-- NEXT_EXTENT                                        NUMBER
-- MIN_EXTENTS                                        NUMBER
-- MAX_EXTENTS                                        NUMBER
-- PCT_INCREASE                                       NUMBER
-- FREELISTS                                          NUMBER
-- FREELIST_GROUPS                                    NUMBER
-- LOGGING                                            VARCHAR2(3)
-- BACKED_UP                                          VARCHAR2(1)
-- NUM_ROWS                                           NUMBER
-- BLOCKS                                             NUMBER
-- EMPTY_BLOCKS                                       NUMBER
-- AVG_SPACE                                          NUMBER
-- CHAIN_CNT                                          NUMBER
-- AVG_ROW_LEN                                        NUMBER
-- AVG_SPACE_FREELIST_BLOCKS                          NUMBER
-- NUM_FREELIST_BLOCKS                                NUMBER
-- DEGREE                                             VARCHAR2(10)
-- INSTANCES                                          VARCHAR2(10)
-- CACHE                                              VARCHAR2(5)
-- TABLE_LOCK                                         VARCHAR2(8)
-- SAMPLE_SIZE                                        NUMBER
-- LAST_ANALYZED                                      DATE

