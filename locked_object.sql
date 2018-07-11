SELECT *
    FROM v$locked_object lo, dba_objects do
    WHERE lo.object_id = do.object_id;

