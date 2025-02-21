/* Процедура */
CREATE PROCEDURE P_Explicit_Index
AS
  DECLARE summa NUMERIC(5,1) = 0;
  DECLARE n_FOR1 NUMERIC(5,1);
  DECLARE bound_n_FOR1 NUMERIC(5,1);  
BEGIN
  n_FOR1 = 1.0;
  bound_n_FOR1 = 3.0;
  WHILE (n_FOR1 <= bound_n_FOR1) DO
  BEGIN 
      summa = :summa + :n_FOR1;
      n_FOR1 = n_FOR1 + 0.5;
  END
  n_FOR1 = bound_n_FOR1;
  n_FOR1 = 2.0;
  bound_n_FOR1 = 3.0;
  WHILE (n_FOR1 <= bound_n_FOR1) DO
  BEGIN 
      summa = :summa + :n_FOR1;
      n_FOR1 = n_FOR1 + 1;
  END
  n_FOR1 = bound_n_FOR1;
END; 

/* Функция */
CREATE FUNCTION F_Explicit_Index
RETURNS NUMERIC(34, 8)
AS
  DECLARE summa NUMERIC(5,1) = 0;
  DECLARE n_FOR1 NUMERIC(5,1);
  DECLARE bound_n_FOR1 NUMERIC(5,1);  
BEGIN
  n_FOR1 = 1.0;
  bound_n_FOR1 = 3.0;
  WHILE (n_FOR1 <= bound_n_FOR1) DO
  BEGIN 
      summa = :summa + :n_FOR1;
      n_FOR1 = n_FOR1 + 0.5;
  END
  n_FOR1 = bound_n_FOR1;
  n_FOR1 = 2.0;
  bound_n_FOR1 = 3.0;
  WHILE (n_FOR1 <= bound_n_FOR1) DO
  BEGIN 
      summa = :summa + :n_FOR1;
      n_FOR1 = n_FOR1 + 1;
  END
  n_FOR1 = bound_n_FOR1;
  RETURN summa;  -- 15
END; 

/* Пакет */
CREATE OR ALTER PACKAGE Pack_Explicit_Index
AS BEGIN
   FUNCTION PF_Explicit_Index
   RETURNS NUMERIC(34, 8);
   PROCEDURE PP_Explicit_Index; 
END; 

RECREATE PACKAGE BODY Pack_Explicit_Index
AS BEGIN
   FUNCTION PF_Explicit_Index
   RETURNS NUMERIC(34, 8)
   AS
     DECLARE summa NUMERIC(5,1) = 0;
     DECLARE n_FOR1 NUMERIC(5,1);
     DECLARE bound_n_FOR1 NUMERIC(5,1);  
   BEGIN
     n_FOR1 = 1.0;
     bound_n_FOR1 = 3.0;
     WHILE (n_FOR1 <= bound_n_FOR1) DO
     BEGIN 
        summa = :summa + :n_FOR1;
        n_FOR1 = n_FOR1 + 0.5;
     END
     n_FOR1 = bound_n_FOR1;
     n_FOR1 = 2.0;
     bound_n_FOR1 = 3.0;
     WHILE (n_FOR1 <= bound_n_FOR1) DO
     BEGIN 
        summa = :summa + :n_FOR1;
        n_FOR1 = n_FOR1 + 1;
     END
     n_FOR1 = bound_n_FOR1;
     RETURN summa;
   END

   PROCEDURE PP_Explicit_Index
   AS
     DECLARE summa NUMERIC(5,1) = 0;
     DECLARE n_FOR1 NUMERIC(5,1);
     DECLARE bound_n_FOR1 NUMERIC(5,1);  
   BEGIN
     n_FOR1 = 1.0;
     bound_n_FOR1 = 3.0;
     WHILE (n_FOR1 <= bound_n_FOR1) DO
     BEGIN 
        summa = :summa + :n_FOR1;
        n_FOR1 = n_FOR1 + 0.5;
     END
     n_FOR1 = bound_n_FOR1;
     n_FOR1 = 2.0;
     bound_n_FOR1 = 3.0;
     WHILE (n_FOR1 <= bound_n_FOR1) DO
     BEGIN 
        summa = :summa + :n_FOR1;
        n_FOR1 = n_FOR1 + 1;
     END
     n_FOR1 = bound_n_FOR1;
   END
END; 

/* Триггер DML */
CREATE OR ALTER TRIGGER T_Explicit_Index
  AFTER INSERT 
  ON students
AS
  DECLARE summa NUMERIC(5,1) = 0;
  DECLARE n_FOR1 NUMERIC(5,1);
  DECLARE bound_n_FOR1 NUMERIC(5,1);  
BEGIN
  n_FOR1 = 1.0;
  bound_n_FOR1 = 3.0;
  WHILE (n_FOR1 <= bound_n_FOR1) DO
  BEGIN 
      summa = :summa + :n_FOR1;
      n_FOR1 = n_FOR1 + 0.5;
  END
  n_FOR1 = bound_n_FOR1;
  n_FOR1 = 2.0;
  bound_n_FOR1 = 3.0;
  WHILE (n_FOR1 <= bound_n_FOR1) DO
  BEGIN 
      summa = :summa + :n_FOR1;
      n_FOR1 = n_FOR1 + 1;
  END
  n_FOR1 = bound_n_FOR1;
END;

/* Анонимный блок */
EXECUTE BLOCK 
AS
  DECLARE summa NUMERIC(5,1) = 0;
  DECLARE n_FOR1 NUMERIC(5,1);
  DECLARE bound_n_FOR1 NUMERIC(5,1);  
BEGIN
  n_FOR1 = 1.0;
  bound_n_FOR1 = 3.0;
  WHILE (n_FOR1 <= bound_n_FOR1) DO
  BEGIN 
      summa = :summa + :n_FOR1;
      n_FOR1 = n_FOR1 + 0.5;
  END
  n_FOR1 = bound_n_FOR1;
  n_FOR1 = 2.0;
  bound_n_FOR1 = 3.0;
  WHILE (n_FOR1 <= bound_n_FOR1) DO
  BEGIN 
      summa = :summa + :n_FOR1;
      n_FOR1 = n_FOR1 + 1;
  END
  n_FOR1 = bound_n_FOR1;
END; 