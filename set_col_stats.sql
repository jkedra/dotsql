-- set_col_stats.sql
--
-- Jerzy Kedra, inspired by Kerry Osborne
--
--
PROMPT ndv = number of distinct values
PROMPT
ACCEPT vowner CHAR  PROMPT  "    owner[me ]: "
ACCEPT vtab   CHAR  PROMPT  "    table[   ]: "
ACCEPT vcol   CHAR  PROMPT  "   column[   ]: "
ACCEPT vpart  CHAR  PROMPT  "partition[all]: "
ACCEPT vndv   NUMBER PROMPT "      ndv[   ]: "
ACCEPT vdens  NUMBER PROMPT "density  [   ]: "
ACCEPT vnull  NUMBER PROMPT "nullcount[   ]: "

BEGIN
    IF(LENGTH('&vtab') = 0 OR LENGTH('&vcol') = 0)
    THEN
	RAISE_APPLICATION_ERROR (
	-20999, 'you have to specify table name and column');
    END IF;
    
    DBMS_STATS.SET_COLUMN_STATS (
    NVL(UPPER('&vowner'), USER), UPPER('&vtab'), UPPER('&vcol'), UPPER('&vpart'),
	distcnt => &vndv,
	density => &vdens,
	nullcnt => &vnull,
	force => TRUE);
END;
/

