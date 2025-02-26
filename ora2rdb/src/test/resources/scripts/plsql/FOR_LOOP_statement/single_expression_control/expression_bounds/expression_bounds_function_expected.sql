CREATE FUNCTION F_Expr_Bounds
RETURNS INTEGER
AS
  DECLARE summa INTEGER = 0;
  DECLARE power INTEGER;
  DECLARE i_FOR1 INTEGER;
BEGIN
  power = 7;
  WHILE (1=1) DO
  BEGIN 
    i_FOR1 = power+1;
    IF (NOT (power < 20)) THEN LEAVE;
    summa = :summa + :i_FOR1;
    power = power+1;
  END
  RETURN summa; 
END; 