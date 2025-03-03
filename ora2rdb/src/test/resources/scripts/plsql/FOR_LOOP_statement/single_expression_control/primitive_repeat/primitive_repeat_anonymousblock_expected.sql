EXECUTE BLOCK 
AS
  DECLARE summa INTEGER = 0;
  DECLARE i_FOR1 INTEGER;
BEGIN
  WHILE (1=1) DO
  BEGIN
    i_FOR1 = 1;
    if (summa > 10) then LEAVE;
    summa = :summa + i_FOR1;
  END
END;