CREATE FUNCTION F_Exit
RETURN VARCHAR2
IS
BEGIN
  FOR i IN 1..3 LOOP
    if i = 3 then 
      EXIT;
    end if;  
  END LOOP;
  RETURN '';
END;