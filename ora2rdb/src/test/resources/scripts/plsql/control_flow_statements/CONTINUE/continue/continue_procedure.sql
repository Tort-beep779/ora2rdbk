CREATE PROCEDURE P_Continue
IS
BEGIN
  FOR i IN 1..3 LOOP
    if i = 1 then 
      CONTINUE;
    end if;  
  END LOOP;
END;
