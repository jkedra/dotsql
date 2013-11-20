-- just a startup
DECLARE
   actual_read INT := 0;
   upper_value INT := 7336403;
BEGIN
   LOOP
      SELECT err_ivc_log_seq.nextval INTO actual_read FROM dual;
      EXIT WHEN actual_read >= upper_value;
   END LOOP;
END;
/

