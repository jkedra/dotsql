
SELECT synonym_name ||' -> '||table_owner||'.'||table_name
       synonyms
FROM all_synonyms
    WHERE owner='PUBLIC'
    AND table_owner NOT IN ('DBMS_PRIVILEGE_CAPTURE',
                            'CTXSYS', 'SYSTEM', 'RDSADMIN',
                            'XDB', 'APPQOSSYS', 'SYS')
;

