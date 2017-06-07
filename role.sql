COL role FORMAT A30

SELECT role FROM dba_roles
   WHERE oracle_maintained<>'Y'
     ORDER BY role;

