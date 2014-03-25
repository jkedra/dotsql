SET LINES 160
COL error_code FORMAT A30
-- GROUP_NUMBER OPERA STAT      POWER     ACTUAL   SOFAR   EST_WORK   EST_RATE EST_MINUTES ERROR_CODE
-- ------------ ----- ---- ---------- ---------- ---------- ---------- ---------- ----------- ------------------------------
           1     REBAL RUN     1            1      13431      16977       3038           1

SELECT group_number g#, operation, state stat, power||'/'||actual pwr,
        sofar,est_work, est_rate rate, est_minutes min, error_code  FROM V$ASM_OPERATION;

