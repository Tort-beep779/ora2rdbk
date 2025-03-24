CREATE FUNCTION F_Explicit_Index
RETURNS NUMERIC(34, 8)
AS
  DECLARE summa NUMERIC(5,1) = 0;
  DECLARE n_FOR1 NUMERIC(5,1);
BEGIN
  WHILE (1=1) DO
  BEGIN
    n_FOR1 = 1.0;
    summa = :summa + n_FOR1;
    LEAVE;
  END 
  RETURN summa; 
END; 