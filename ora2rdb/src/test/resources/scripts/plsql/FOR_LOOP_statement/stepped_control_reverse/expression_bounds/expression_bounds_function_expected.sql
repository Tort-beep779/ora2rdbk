CREATE FUNCTION F_Expr_Bounds
RETURNS INTEGER
AS
  DECLARE summa INTEGER = 0;
  DECLARE power INTEGER;
  DECLARE i_FOR1 INTEGER;
  DECLARE bound_i_FOR1 INTEGER;  
BEGIN
  power = 7;
  i_FOR1 = power+5;
  bound_i_FOR1 = power+3;
  WHILE (i_FOR1 >= bound_i_FOR1) DO
  BEGIN 
      summa = :summa + :i_FOR1;
      power = 10;
      i_FOR1 = i_FOR1 - 1;
  END
  i_FOR1 = bound_i_FOR1;
  RETURN summa; --33
END; 