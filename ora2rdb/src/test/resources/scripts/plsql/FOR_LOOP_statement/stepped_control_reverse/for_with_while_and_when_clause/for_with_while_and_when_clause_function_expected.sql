CREATE FUNCTION F_For_With_While_and_When
RETURNS INTEGER
AS
  DECLARE summa INTEGER = 0;
  DECLARE i_FOR1 INTEGER;
  DECLARE bound_i_FOR1 INTEGER;
BEGIN
  i_FOR1 = 10;
  bound_i_FOR1 = 1;
  WHILE (i_FOR1 >= bound_i_FOR1) DO
  BEGIN 
    IF (NOT(i_FOR1 > 5)) THEN LEAVE;
    IF (NOT (i_FOR1 != 8)) THEN                       
    BEGIN 
      i_FOR1 = i_FOR1 - 1; 
      CONTINUE;
    END
    summa = :summa + :i_FOR1;
    i_FOR1 = i_FOR1 - 1;
  END
  i_FOR1 = bound_i_FOR1;
  RETURN summa;  -- 32
END; 