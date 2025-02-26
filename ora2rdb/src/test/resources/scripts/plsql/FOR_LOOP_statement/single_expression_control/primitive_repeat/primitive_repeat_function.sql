CREATE FUNCTION F_Primitive_Repeat
RETURN PLS_INTEGER
IS
  summa PLS_INTEGER := 0;
BEGIN
  FOR i IN REPEAT 1
  LOOP
      if summa > 10 then exit; end if;
      summa := summa + i;
  END LOOP;
  RETURN summa;
END; 