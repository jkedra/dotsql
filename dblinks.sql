-- vim:ts=4:expandtab
-- jurek.kedra@gmail.com
--
SET LINES 160
COL owner	FORMAT A10
COL username	FORMAT A10
COL db_link	FORMAT A10
COL host	FORMAT A40
SELECT owner,db_link,username,host,created
FROM all_db_links;
