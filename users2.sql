SET LINES 160
COL username FORMAT A16
COL profile FORMAT A18
COL s FORMAT A1
COL default_tablespace HEADING 'tblspc' FORMAT A10
COL temporary_tablespace HEADING 'tempspc' FORMAT A10


PROMPT +=======================================+=====================+
PROMPT |     STATUS  (S)        | DATE FORMAT  | LOCKD = LOCK DATE   |
PROMPT | O = OPEN               | YYYYMMDD     | EXPD  = EXPIRY DATE |
PROMPT | L = LOCKED             |              |                     |
PROMPT | E = EXPIRED AND LOCKED |              |                     |
PROMPT | G = EXPIRED(GRACE)     |              |                     |
PROMPT +=============================================================+
PROMPT 
SET ESCAPE ON
SELECT username, profile, default_tablespace, temporary_tablespace,
       DECODE(account_status,
                    'OPEN', 'O',
                    'LOCKED', 'L',
                    'EXPIRED \& LOCKED', 'E',
                    'EXPIRED',           'E',
                    'EXPIRED(GRACE)', 'G',
                    'LOCKED(TIMED)', 'T',
                    account_status) S,
            TO_CHAR(lock_date,   'YYYYMMDD') lockd,
            TO_CHAR(expiry_date, 'YYYYMMDD') expd
   FROM dba_users
   WHERE username  IN ('SG891757', 'SG899382',
                        'TASDBA', 'TASGEN', 'TASUSR', 'TASADMIN',
                        'ASDM', 'AUTOUSER',
                        'ZABBIX')
    OR REGEXP_LIKE(username, '..(WEB|BAT).$')
    OR REGEXP_LIKE(username, '^LPS.*')
ORDER BY username, profile
/
SET ESCAPE OFF
