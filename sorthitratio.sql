select a.value "disk sorts", b.value "memory sorts", round(100*b.value)/decode((a.value+b.value),0,1,(a.value+b.value)) "pct memory sorts" from v$sysstat a, v$sysstat b where a.name='sorts (disk)' and b.name ='sorts (memory)';

