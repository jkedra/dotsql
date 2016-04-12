col sidser format a20

SELECT * FROM (
SELECT oc.inst_id,oc.sid||','||s.serial# sidser ,count(*) from gv$open_cursor oc, gv$session s
WHERE oc.inst_id=s.inst_id AND oc.saddr=s.saddr
GROUP BY oc.inst_id,oc.sid||','||s.serial#
ORDER BY count(*) DESC
)
WHERE rownum <= 10
/


