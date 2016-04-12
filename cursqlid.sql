SET NUMWIDTH 6
col sql_text format a40 word_wrapped

SELECT  sid, sql_id, sql_text, count(*) cursors
FROM v$open_cursor where sid in (&1)
GROUP by sid, sql_text, sql_id
ORDER BY 4 DESC;
