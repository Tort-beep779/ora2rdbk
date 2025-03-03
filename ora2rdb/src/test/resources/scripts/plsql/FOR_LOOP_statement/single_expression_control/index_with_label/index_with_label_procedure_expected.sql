CREATE PROCEDURE P_Index_With_Label
AS
  DECLARE summa INTEGER = 0;
  DECLARE i_FOR1 INTEGER;
BEGIN
  forlabel:
  WHILE (1=1) DO
  BEGIN
    i_FOR1 = 1;
    summa = :summa + i_FOR1;
    LEAVE;
  END
END; 