CREATE OR ALTER TRIGGER T_For_With_Mutable_Index
  AFTER INSERT 
  ON students
AS
  DECLARE summa INTEGER = 0;
  DECLARE i_FOR1 INTEGER;
BEGIN
  WHILE (1=1) DO
  BEGIN
    i_FOR1 = 1;
    i_FOR1 = i_FOR1 +1;
    summa = :summa + i_FOR1;
    if (summa > 10) then LEAVE; 
  END
END; 