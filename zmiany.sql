col obj format a20

TTITLE SKIP 2 CENTER "ZMIANY OSTATNIEJ DOBY" SKIP 2

select owner ||'.'||object_name obj,
       timestamp,created,last_ddl_time from dba_objects
where	object_type in ('PACKAGE', 'PACKAGE BODY', 'PROCEDURE', 'TRIGGER')
and     sysdate-last_ddl_time<1
order by last_ddl_time
/
