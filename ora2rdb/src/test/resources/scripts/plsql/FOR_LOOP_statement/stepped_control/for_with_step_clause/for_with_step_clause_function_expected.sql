CREATE FUNCTION F_For_With_Step
RETURNS INTEGER
AS 
  DECLARE summa INTEGER = 0;
  DECLARE i_FOR1 INTEGER;
  DECLARE bound_i_FOR1 INTEGER;
BEGIN
  i_FOR1 = 5;
  bound_i_FOR1 = 15;
  WHILE (i_FOR1 <= bound_i_FOR1) DO
  BEGIN 
      summa = :summa + :i_FOR1;
      i_FOR1 = i_FOR1 + 5;
  END
  i_FOR1 = bound_i_FOR1;
  RETURN summa;  -- 30
END; 