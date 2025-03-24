CREATE FUNCTION F_Explicit_Index
RETURNS NUMERIC(34, 8)
AS
  DECLARE summa NUMERIC(5,1) = 0;
  DECLARE n_FOR1 NUMERIC(5,1);
  DECLARE bound_n_FOR1 NUMERIC(5,1);  
BEGIN
  n_FOR1 = 3.0;
  bound_n_FOR1 = 1.0;
  WHILE (n_FOR1 >= bound_n_FOR1) DO
  BEGIN 
      summa = :summa + :n_FOR1;
      n_FOR1 = n_FOR1 - 0.5;
  END
  n_FOR1 = bound_n_FOR1;
  RETURN summa;  -- 10
END; 