EXECUTE BLOCK 
AS
  DECLARE summa INTEGER = 0;
  DECLARE i_FOR1 INTEGER;
  DECLARE bound_i_FOR1 INTEGER;
  DECLARE i_FOR2 INTEGER;
  DECLARE bound_i_FOR2 INTEGER;
BEGIN
  i_FOR1 = 1;
  bound_i_FOR1 = 3;
  WHILE (i_FOR1 <= bound_i_FOR1) DO
  BEGIN 
      summa = :summa + :i_FOR1;
      i_FOR1 = i_FOR1 + 1;
  END
  i_FOR1 = bound_i_FOR1;
  i_FOR2 = 50;
  bound_i_FOR2 = 53;
  WHILE (i_FOR2 <= bound_i_FOR2) DO
  BEGIN 
      summa = :summa + :i_FOR2;
      i_FOR2 = i_FOR2 + 1;
  END
  i_FOR2 = bound_i_FOR2;
END; 