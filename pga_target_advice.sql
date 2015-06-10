 -- ************************************************
-- Display shared pool advice
-- ************************************************
 
set lines  100
set pages  999
 
column        c1     heading 'Pool|Size(M)'
column        c2     heading 'Size|Factor'
column        c5     heading 'EstCache|HitPercent'
column        c6     heading 'Est|Overalloc|Count' format 999,999,999
 
SELECT
   pga_target_for_estimate  c1,
   pga_target_factor        c2,
   estd_pga_cache_hit_percentage c5,
   estd_overalloc_count c6
FROM
   v$pga_target_advice
ORDER BY pga_target_factor ASC;

