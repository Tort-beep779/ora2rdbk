CREATE FUNCTION F_Expr_Bounds
RETURN PLS_INTEGER
IS
  summa PLS_INTEGER := 0;
  power PLS_INTEGER;
BEGIN
  power := 7;
  FOR i IN power+3..power+5 
  LOOP
      summa := summa + i;
      power := 10;
  END LOOP;
  RETURN summa; --33
END; 