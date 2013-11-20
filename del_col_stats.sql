-- Jerzy Kedra
ACCEPT vowner CHAR PROMPT "owner    [current]: "
ACCEPT vtab   CHAR PROMPT "table    [       ]: "
ACCEPT vcol   CHAR PROMPT "column   [       ]: "
ACCEPT vpart  CHAR PROMPT "partition[    all]: "

BEGIN
    IF(LENGTH('&vtab') = 0 OR LENGTH('&vcol') = 0)
    THEN
	RAISE_APPLICATION_ERROR (
	-20999, 'you have to specify table name and column');
    END IF;
    
    DBMS_STATS.DELETE_COLUMN_STATS (
    NVL(UPPER('&vowner'), USER), UPPER('&vtab'), UPPER('&vcol'), UPPER('&vpart'), force => TRUE);
END;
/

