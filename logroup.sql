-- Do automatycznego i szybkiego przelaczania do
-- LOW_GROUP, np. w celu budowania indeksow.
--
-- Jerzy Kedra, 19.02.2003
--


SET SERVEROUTPUT ON;
SET FEEDBACK OFF
PROMPT

DECLARE
	vsid		NUMBER;
	vserial		NUMBER;	
	vplan		VARCHAR2(32);
BEGIN
	select name into vplan from v$rsrc_plan;

	select sid,serial# into vsid,vserial
	from v$session where audsid=userenv('sessionid');

	DBMS_OUTPUT.put_line('SID/SERIAL ('||vsid||'/'||vserial||')');
	DBMS_OUTPUT.put_line('Active Plan: ' || vplan);

	DBMS_RESOURCE_MANAGER.SWITCH_CONSUMER_GROUP_FOR_SESS(vsid,vserial,'LOW_GROUP');

	EXCEPTION
	WHEN NO_DATA_FOUND THEN
		DBMS_OUTPUT.PUT_LINE('No Active Resource Plan');
	WHEN TOO_MANY_ROWS THEN
		DBMS_OUTPUT.PUT_LINE('No, Please! Not with SYS account!');
END;
/

SET FEEDBACK ON
PROMPT
