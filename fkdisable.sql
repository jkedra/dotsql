COL SQL FORMAT A78

SELECT 'ALTER TABLE '||table_name||' MODIFY CONSTRAINT '||constraint_name||' DISABLE;' sql
FROM user_constraints
WHERE table_name='&1'
	AND constraint_type='R'
	AND status='ENABLED';
