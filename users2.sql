SET LINES 160
COL username FORMAT A16
COL profile FORMAT A16
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
                    'EXPIRED \& LOCKED', 'E',
                    'EXPIRED(GRACE)', 'G',
                    account_status) S,
            TO_CHAR(lock_date,   'YYYYMMDD') lockd,
            TO_CHAR(expiry_date, 'YYYYMMDD') expd
   FROM dba_users
   WHERE username  IN ('SG891757', 'TASDBA', 'TASGEN')
/
SET ESCAPE OFF
