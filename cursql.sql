SET NUMWIDTH 6
col sql_text format a40 word_wrapped

SELECT  sid,sql_text, count(*) as "OPEN CURSORS"
FROM v$open_cursor where sid in (&1)
GROUP by sid, sql_text
ORDER BY 3 DESC;
