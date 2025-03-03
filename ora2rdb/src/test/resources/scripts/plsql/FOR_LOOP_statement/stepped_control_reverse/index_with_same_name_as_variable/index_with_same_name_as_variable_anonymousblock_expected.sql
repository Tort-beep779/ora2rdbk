EXECUTE BLOCK 
AS
  DECLARE summa INTEGER = 0;
  DECLARE i INTEGER;
  DECLARE i_FOR1 INTEGER;
  DECLARE bound_i_FOR1 INTEGER;
BEGIN
  i_FOR1 = 3;
  bound_i_FOR1 = 1;
  WHILE (i_FOR1 >= bound_i_FOR1) DO
  BEGIN 
      summa = :summa + :i_FOR1;
      i_FOR1 = i_FOR1 - 1;
  END
  i_FOR1 = bound_i_FOR1;
  i = 10;
  summa = :summa + :i;
END; 