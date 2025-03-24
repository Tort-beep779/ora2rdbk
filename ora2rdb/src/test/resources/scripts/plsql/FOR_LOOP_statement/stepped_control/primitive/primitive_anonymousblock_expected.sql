EXECUTE BLOCK 
AS
  DECLARE summa INTEGER = 0;
  DECLARE done CHAR(1) = 'F';
  DECLARE i_FOR1 INTEGER;
  DECLARE bound_i_FOR1 INTEGER;
BEGIN
  i_FOR1 = 1;
  bound_i_FOR1 = 3;
  WHILE (i_FOR1 <= bound_i_FOR1) DO
  BEGIN 
      summa = :summa + :i_FOR1;
      done = 'T';
      i_FOR1 = i_FOR1 + 1;
  END
  i_FOR1 = bound_i_FOR1;
END; 