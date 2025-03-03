CREATE OR REPLACE TRIGGER T_Expr_Bounds
  AFTER INSERT 
  ON students
  FOR EACH ROW
DECLARE
  summa PLS_INTEGER := 0;
  power PLS_INTEGER;
BEGIN
  power := 7;
  FOR i IN REPEAT power+1 while power < 20
  LOOP
      summa := summa + i;
      power := power + 1;
  END LOOP;
END;