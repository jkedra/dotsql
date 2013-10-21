select sum(pins) / (sum(pins) + sum(reloads)) * 100 "Hit ratio" from v$librarycache;
