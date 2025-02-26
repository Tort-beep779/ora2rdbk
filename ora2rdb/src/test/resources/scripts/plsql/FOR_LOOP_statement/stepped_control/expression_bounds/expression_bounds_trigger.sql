CREATE OR REPLACE TRIGGER T_Expr_Bounds
  AFTER INSERT 
  ON students
  FOR EACH ROW
DECLARE
  summa PLS_INTEGER := 0;
  power PLS_INTEGER;
BEGIN
  power := 7;
  FOR i IN power+3..power+5 
  LOOP
      summa := summa + i;
      power := 10;
  END LOOP;
END;