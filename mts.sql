set pages 30
set lines 85 
column name format a22
column sid format a10
column value format a35 word
column isspecified heading "IsSpecified" format a6
select distinct name, sid, value, isspecified
  from gv$spparameter
        where name in ( 'local_listener', 'remote_listener', 'dispatchers',
                        'shared_servers','shared_server_sessions', 'max_shared_servers', 'sessions', 'processes' )
        order by name, sid, value
;

