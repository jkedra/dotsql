
PROMPT C|O = CYCLE|ORDER
PROMPT CS  = CACHE SIZE

COL "min-last-max" FORMAT A30
COL cs FORMAT 999

SELECT min_value||'->'||last_number||'->'||max_value "min-last-max",
	CYCLE_FLAG||'|'|| ORDER_FLAG "C|O", CACHE_SIZE cs
FROM user_sequences WHERE sequence_name='&1';
