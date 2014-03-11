-- http://dbatrain.wordpress.com/2010/11/22/do-you-have-an-oracle-background/
-- values in microseconds

SET LINES 160
PROMPT value in microseconds
COL stat_name FORMAT A65
SET NUMWIDTH 16

select lpad( ' ', ( level - 1 ) * 2 )  ||
      stat_name as stat_name
    , ROUND(value/1000,2) ms
    , case stat_name
        when 'background elapsed time'                           then '1'
        when 'background cpu time'                               then '1-1'
        when 'RMAN cpu time (backup/restore)'                    then '1-1-1'
        when 'DB time'                                           then '2'
        when 'DB CPU'                                            then '2-1'
         when 'connection management call elapsed time'           then '2-2'
         when 'sequence load elapsed time'                        then '2-3'
         when 'sql execute elapsed time'                          then '2-4'
         when 'parse time elapsed'                                then '2-5'
         when 'hard parse elapsed time'                           then '2-5-1'
         when 'hard parse (sharing criteria) elapsed time'        then '2-5-1-1'
         when 'hard parse (bind mismatch) elapsed time'           then '2-5-1-1-1'
         when 'failed parse elapsed time'                         then '2-5-2'
         when 'failed parse (out of shared memory) elapsed time'  then '2-5-2-1'
         when 'PL/SQL execution elapsed time'                     then '2-6'
         when 'inbound PL/SQL rpc elapsed time'                   then '2-7'
         when 'PL/SQL compilation elapsed time'                   then '2-8'
         when 'Java execution elapsed time'                       then '2-9'
         when 'repeated bind elapsed time'                        then '2-A'
         else '9'
       end as pos
  from (
         select /*+ no_merge */
                stat_name
              , stat_id
              , value
              , case
                when stat_id in (2411117902)
                then 2451517896
                when stat_id in (268357648)
                then 3138706091
                when stat_id in (3138706091)
                then 372226525
                when stat_id in (4125607023)
                then 1824284809
                when stat_id in (2451517896)
                then 4157170894
                when stat_id in (372226525,1824284809)
                then 1431595225
                when stat_id in (3649082374,4157170894)
                then null
                else 3649082374
                end parent_stat_id
           from v$sys_time_model
       )
connect by prior stat_id = parent_stat_id
start with parent_stat_id is null
order by pos;
