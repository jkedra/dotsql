-- http://www.centrexcc.com/Using%20DBMS_STATS%20in%20Access%20Path%20Optimization.pdf
select do.owner||'.'||do.object_name obj,
intcol#,equality_preds,equijoin_preds,nonequijoin_preds,range_preds,like_preds,null_preds,cu.timestamp
from sys.col_usage$ cu, dba_objects do
where cu.obj#=do.object_id
and do.owner='TASDBA'
order by 1,2;

