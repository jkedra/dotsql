 -- ************************************************
-- Display shared pool advice
-- ************************************************
 
set lines  100
set pages  999
 
column        c1     heading 'Pool |Size(M)'
column        c2     heading 'Size|Factor'
column        c3     heading 'Est|LC(M)  '
column        c4     heading 'Est LC|Mem. Obj.'
column        c5     heading 'Est|Time|Saved|(sec)'
column        c6     heading 'Est|Parse|Saved|Factor'
column c7     heading 'Est|Object Hits'   format 999,999,999
 
 
SELECT
   shared_pool_size_for_estimate  c1,
   shared_pool_size_factor        c2,
   estd_lc_size                   c3,
   estd_lc_memory_objects         c4,
   estd_lc_time_saved                    c5,
   estd_lc_time_saved_factor             c6,
   estd_lc_memory_object_hits            c7
FROM
   v$shared_pool_advice;

