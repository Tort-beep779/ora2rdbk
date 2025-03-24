CREATE FUNCTION F_For_With_Immutable_Index
RETURNS INTEGER
AS
  DECLARE summa INTEGER = 0;
  DECLARE i_FOR1 INTEGER;
BEGIN
  WHILE (1=1) DO
  BEGIN
    i_FOR1 = 1;
    summa = :summa + i_FOR1;
    LEAVE; 
  END
  RETURN summa; 
END; 