SET LINES 120
COL filename FORMAT A30
COL type FORMAT A15

SELECT filename,
       ROUND(filesize/1024/1024,2) MB,
       type,mtime from table(RDSADMIN.RDS_FILE_UTIL.LISTDIR('DATA_PUMP_DIR'))
/
