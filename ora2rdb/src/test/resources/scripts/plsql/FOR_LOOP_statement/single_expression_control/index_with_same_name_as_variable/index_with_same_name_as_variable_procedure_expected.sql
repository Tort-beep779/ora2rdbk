CREATE PROCEDURE P_Same_Name_Var
AS
  DECLARE summa INTEGER = 0;
  DECLARE i INTEGER;
  DECLARE i_FOR1 INTEGER;
BEGIN
  WHILE (1=1) DO
  BEGIN
    i_FOR1 = 1;
    summa = :summa + i_FOR1;
    LEAVE;
  END
  i = 10;
  summa = :summa + i;
END; 