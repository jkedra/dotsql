
PROMPT C|O = CYCLE|ORDER
PROMPT CS  = CACHE SIZE
PROMPT it expects one argument with sequence name

COL "min-last-max" FORMAT A30
COL cs FORMAT 999

SET VERIFY OFF

SELECT min_value||'->'||last_number||'->'||max_value "min-last-max",
	CYCLE_FLAG||'|'|| ORDER_FLAG "C|O", CACHE_SIZE cs
FROM user_sequences WHERE sequence_name=UPPER('&1');

SET VERIFY ON
