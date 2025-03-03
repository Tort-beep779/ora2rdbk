CREATE PROCEDURE P_For_With_Step
AS 
  DECLARE summa INTEGER = 0;
  DECLARE i_FOR1 INTEGER;
  DECLARE bound_i_FOR1 INTEGER;
BEGIN
  i_FOR1 = 3;
  bound_i_FOR1 = 9;
  WHILE (i_FOR1 <= bound_i_FOR1) DO
  BEGIN 
      summa = :summa + :i_FOR1;
      i_FOR1 = i_FOR1 + 3;
  END
  i_FOR1 = bound_i_FOR1;
  i_FOR1 = 15;
  bound_i_FOR1 = 5;
  WHILE (i_FOR1 >= bound_i_FOR1) DO
  BEGIN 
      summa = :summa + :i_FOR1;
      i_FOR1 = i_FOR1 - 5;
  END
  i_FOR1 = bound_i_FOR1;
END; 