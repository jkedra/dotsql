-- jxa
-- informacje o indeksie
--
SET ECHO OFF
SET VERIFY OFF
SET SERVEROUTPUT ON

ACCEPT schema_name PROMPT 'Enter schema name [CNP]            : ' DEFAULT CNP
ACCEPT index_name  PROMPT 'Enter index name  [konto_slot_fk_i]: ' DEFAULT konto_slot_fk_i

PROMPT ==
PROMPT == "&schema_name"."&index_name"
PROMPT ==

DECLARE
	TYPE dba_idx_type	IS RECORD (
		index_type		DBA_INDEXES.index_type%TYPE,
		table_owner		DBA_INDEXES.table_owner%TYPE,
		table_name		DBA_INDEXES.table_name%TYPE,
		tablespace_name		DBA_INDEXES.tablespace_name%TYPE,
		blevel			DBA_INDEXES.blevel%TYPE,
		leaf_blocks		DBA_INDEXES.leaf_blocks%TYPE,
		distinct_keys		DBA_INDEXES.distinct_keys%TYPE,
		clustering_factor	DBA_INDEXES.clustering_factor%TYPE,
		status			DBA_INDEXES.status%TYPE,
		last_analyzed		DBA_INDEXES.last_analyzed%TYPE,
		buffer_pool		DBA_INDEXES.buffer_pool%TYPE
	);
		
	iname		VARCHAR2(64);
	sname		VARCHAR2(64);
	isize		NUMBER;
	dba_idx		DBA_IDX_TYPE;
	created		DBA_OBJECTS.created%TYPE;
	last_ddl_time	DBA_OBJECTS.last_ddl_time%TYPE;

BEGIN
	DBMS_OUTPUT.ENABLE;
	SELECT upper('&index_name')  INTO iname FROM dual;
	SELECT upper('&schema_name') INTO sname FROM dual;


	SELECT index_type,table_owner,table_name,tablespace_name,
	       blevel,leaf_blocks,distinct_keys,clustering_factor,
	       status,last_analyzed,buffer_pool
		INTO dba_idx
		FROM dba_indexes WHERE owner=sname AND index_name=iname;


	SELECT sum(bytes) INTO isize FROM dba_segments
		WHERE owner=sname AND segment_name=iname;

	SELECT created,last_ddl_time INTO created,last_ddl_time
		FROM dba_objects WHERE owner=sname AND object_name=iname;

	DBMS_OUTPUT.PUT_LINE('idx table         : ' || dba_idx.table_owner ||'.'|| dba_idx.table_name);
	DBMS_OUTPUT.PUT_LINE('idx tablespace    : ' || dba_idx.tablespace_name);
	DBMS_OUTPUT.PUT_LINE('index type        : ' || dba_idx.index_type);
	DBMS_OUTPUT.PUT_LINE('blevel            : ' || dba_idx.blevel);
	DBMS_OUTPUT.PUT_LINE('leaf blocks       : ' || dba_idx.leaf_blocks);
	DBMS_OUTPUT.PUT_LINE('distinct keys     : ' || dba_idx.distinct_keys);
	DBMS_OUTPUT.PUT_LINE('clustering factor : ' || dba_idx.clustering_factor);
	DBMS_OUTPUT.PUT_LINE('status            : ' || dba_idx.status);
	DBMS_OUTPUT.PUT_LINE('last_analyzed     : ' || dba_idx.last_analyzed);
	DBMS_OUTPUT.PUT_LINE('created           : ' || created);
	DBMS_OUTPUT.PUT_LINE('last_ddl_time     : ' || last_ddl_time);
	DBMS_OUTPUT.PUT_LINE('buffer_pool       : ' || dba_idx.buffer_pool);
	DBMS_OUTPUT.PUT_LINE('idx size          : ' || isize/1024/1024 || ' MB');
END;
/

--SELECT index_type,table_owner,table_name,tablespace_name,blevel,LEAF_BLOCKS,DISTINCT_KEYS,CLUSTERING_FACTOR,status,last_analyzed,buffer_pool
--FROM dba_indexes where owner=upper('&schema_name') and index_name=upper('&index_name');

