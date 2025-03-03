EXECUTE BLOCK 
AS
  DECLARE summa INTEGER = 0;
  DECLARE power INTEGER;
  DECLARE i_FOR1 INTEGER;
  DECLARE bound_i_FOR1 INTEGER;
BEGIN
  power = 7;
  WHILE (1=1) DO
  BEGIN 
    i_FOR1 = power+1;
    IF (NOT (power < 20)) THEN LEAVE;
    summa = :summa + :i_FOR1;
    power = power + 1;
  END
  WHILE (1=1) DO
  BEGIN 
    i_FOR1 = 21;
    summa = :summa + :i_FOR1;
    power = power + 1;
    LEAVE;
  END
  i_FOR1 = 1;
  bound_i_FOR1 = 3;
  WHILE (i_FOR1 <= bound_i_FOR1) DO
  BEGIN 
    summa = :summa + :i_FOR1;
    power = power + 1;
    i_FOR1 = i_FOR1 + 1; 
  END
  i_FOR1 = bound_i_FOR1;
END; 