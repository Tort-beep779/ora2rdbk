CREATE PROCEDURE P_For_With_While
AS
  DECLARE summa INTEGER = 0;
  DECLARE power_FOR1 INTEGER;
BEGIN
  WHILE (1=1) DO
  BEGIN 
    power_FOR1 = 2;
    summa = :summa + :power_FOR1;
    LEAVE;
  END
  WHILE (1=1) DO
  BEGIN 
    power_FOR1 = power_FOR1*2;
    IF (NOT (power_FOR1 <= 64)) THEN LEAVE;
    summa = :summa + :power_FOR1;
  END
END; 