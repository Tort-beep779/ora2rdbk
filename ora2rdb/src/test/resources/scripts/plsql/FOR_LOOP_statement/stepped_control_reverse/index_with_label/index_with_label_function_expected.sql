CREATE FUNCTION F_Index_With_Label
RETURNS INTEGER
AS
  DECLARE summa INTEGER = 0;
  DECLARE i_FOR1 INTEGER;
  DECLARE bound_i_FOR1 INTEGER;
BEGIN
  i_FOR1 = 3;
  bound_i_FOR1 = 1;
  forlabel:
  WHILE (i_FOR1 >= bound_i_FOR1) DO
  BEGIN  
    summa = :summa + i_FOR1;
    i_FOR1 = i_FOR1 - 1;
  END /*forlabel*/
  i_FOR1 = bound_i_FOR1;
  RETURN summa;  -- 6
END; 