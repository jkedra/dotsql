SET VERIFY OFF
COL OBJECT_NAME FORMAT A30
COL subobject_name FORMAT A20
COL object_type FORMAT A20

SELECT object_name,subobject_name,object_type
    FROM dba_objects WHERE owner='&owner'
    ORDER BY 3,2,1
/
