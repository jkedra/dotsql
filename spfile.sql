 SELECT DECODE(value, NULL, 'PFILE', 'SPFILE') "Init File Type" 
       FROM sys.v_$parameter WHERE name = 'spfile';
