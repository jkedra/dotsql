
SET NUMWIDTH 6
SET LINESIZE 100
COLUMN SQL FORMAT A40


-- exec = users executing
-- open = users opening

PROMPT EXEC = users executing
PROMPT OPEN = users opening

SELECT * FROM (
SELECT version_count ,
                  users_opening		u_open,
                  users_executing	u_exec,
                  substr(sql_text,1,40) "SQL"
            FROM v$sqlarea
           WHERE version_count > 10
    order by version_count desc
)
WHERE ROWNUM < 10
/

