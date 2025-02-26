CREATE OR ALTER TRIGGER T_For_With_Mutable_Index
  AFTER INSERT 
  ON students
AS
  DECLARE summa INTEGER = 0;
  DECLARE i_FOR1 INTEGER;
  DECLARE bound_i_FOR1 INTEGER;
BEGIN
  i_FOR1 = 1;
  bound_i_FOR1 = 10;
  WHILE (i_FOR1 <= bound_i_FOR1) DO
  BEGIN 
      i_FOR1 = i_FOR1 + 1;
      summa = :summa + :i_FOR1;
      i_FOR1 = i_FOR1 + 1;
  END
  i_FOR1 = bound_i_FOR1;
END; 