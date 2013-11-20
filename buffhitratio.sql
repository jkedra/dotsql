select (1 - (sum(decode(name, 'physical reads', value,0)) / (sum(decode(name, 'db_block gets', value, 0)) + sum(decode(name, 'consistent gets', value, 0))))) * 100 "Hit Ratio" from v$sysstat;

