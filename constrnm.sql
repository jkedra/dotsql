COL table_name FORMAT A25
COL constraint_type FORMAT A1
COL search_condition FORMAT A50 WORD_WRAPPED
SET LINES 80

ACCEPT owner CHAR PROMPT    "owner       [  ]: "
ACCEPT constrnm CHAR PROMPT "constr name [  ]: "

SELECT table_name,constraint_type,search_condition
    FROM all_constraints
        WHERE owner=NVL(UPPER('&owner'), USER)
          AND constraint_name=UPPER('&constrnm');


