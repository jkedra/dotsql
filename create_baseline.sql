-- http://kerryosborne.oracle-guy.com/2009/04/oracle-11g-sql-plan-management-sql-plan-baselines/

var ret number
exec :ret := dbms_spm.load_plans_from_cursor_cache(-
    sql_id=>'&sql_id', -
    plan_hash_value=>&plan_hash_value,-
    fixed=>'&fixed');
