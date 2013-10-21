-- (c) Jerzy Kedra 2013
COL col FORMAT a8
COL value_string FORMAT a20
col name FORMAT a8 HEADING "bind|name"
col val FORMAT a20 HEADING "value|captured"
col datatype_string format A20 HEADING "datatype|string"
col whencapt HEADING "when|captured"
COL was_captured HEADING "was|cap"

SELECT name, datatype_string, was_captured,
       to_char(last_captured, 'DD.MM HH24:MI') whencapt,
       CASE WHEN datatype_string='TIMESTAMP'
       THEN TO_CHAR(anydata.accesstimestamp(value_anydata),
                    'YYYY.MM.DD HH24:MI:SS')
       ELSE value_string
       END val       
FROM v$sql_bind_capture
WHERE sql_id = '&sql_id'
	AND child_number=NVL('&child_number',child_number)
ORDER BY sql_id,child_number,position;


