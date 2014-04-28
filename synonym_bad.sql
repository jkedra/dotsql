SELECT ds.owner,ds.synonym_name,ds.table_owner,ds.table_name
FROM dba_synonyms ds, dba_objects do
WHERE ds.owner=do.owner AND do.object_name=ds.synonym_name
AND do.status<>'VALID'
AND NOT EXISTS (SELECT * FROM dba_objects do2
                WHERE ds.table_owner=DO2.OWNER
                AND ds.table_name=DO2.OBJECT_NAME
                AND do2.object_type IN ('TABLE','VIEW','FUNCTION','PROCEDURE','PACKAGE'));

