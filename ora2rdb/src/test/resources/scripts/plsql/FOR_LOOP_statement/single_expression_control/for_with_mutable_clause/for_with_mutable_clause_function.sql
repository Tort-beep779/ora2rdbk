CREATE FUNCTION F_For_With_Mutable_Index
RETURN PLS_INTEGER
IS
  summa PLS_INTEGER := 0;
BEGIN
  FOR i MUTABLE IN REPEAT 1 LOOP
      i := i+1;
      summa := summa + i;   
      if summa > 10 then exit; end if;
  END LOOP;
  RETURN summa;  
END; 