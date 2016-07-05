
PROMPT Spooling to /tmp/fkall_*.sql

SET HEAD OFF FEEDBACK OFF
SET ECHO OFF TERMOUT OFF

SET TRIMSPOOL ON
SET PAGES 0 LINES 2000
--SET VERIFY OFF

SET FEEDBACK OFF
SPOOL /tmp/fkall_disable.sql
SELECT 'ALTER TABLE '||table_name||' MODIFY CONSTRAINT '||constraint_name||' DISABLE;' sql
FROM user_constraints
WHERE constraint_type='R'
      AND status='ENABLED';
SPOOL OFF

SPOOL /tmp/fkall_enable.sql
SELECT 'ALTER TABLE '||table_name||' MODIFY CONSTRAINT '||constraint_name||' ENABLE VALIDATE;' sql
FROM user_constraints
WHERE constraint_type='R'
      AND status='ENABLED';
SPOOL OFF

SET HEAD ON FEEDBAK ON 
