EXECUTE BLOCK 
AS
  DECLARE summa INTEGER = 0;
  DECLARE done CHAR(1) = 'F';
  DECLARE i_FOR1 INTEGER;
BEGIN
  WHILE (1=1) DO
  BEGIN
    i_FOR1 = 1;
    summa = :summa + i_FOR1;
    done = 'T';
    LEAVE;
  END
END; 