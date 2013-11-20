select (1-(sum(getmisses)/sum(gets))) * 100 "Hit Ratio" from v$rowcache
/
