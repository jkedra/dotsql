-- Dumps body of a trigger/procedure/function 
-- Source lines count start with DECLARE/BEGIN
--
-- Jerzy Kedra
--
WITH b AS (
SELECT min(line) line,name, type FROM (
    SELECT min(line) line,
        REGEXP_REPLACE(UPPER(text),
                       '.*(\s|\A)+(BEGIN|DECLARE)(\s|$).*', '\2') text2,
        name, type
    FROM user_source
    WHERE REGEXP_LIKE(UPPER(text),
                        '(\s|\A)+(BEGIN|DECLARE)(\s|$)')
    GROUP BY REGEXP_REPLACE(UPPER(text),
                            '.*(\s|\A)+(BEGIN|DECLARE)(\s|$).*', '\2'),
          name, type
)
GROUP BY name, type)
SELECT line-(SELECT line FROM b WHERE type=us.type AND name=us.name)+1 lno,text
FROM user_source us WHERE name='&object_name';

