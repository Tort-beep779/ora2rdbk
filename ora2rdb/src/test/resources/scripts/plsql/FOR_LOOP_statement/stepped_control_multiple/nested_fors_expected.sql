/* Процедура */
CREATE PROCEDURE P_Nested_Fors
AS
  DECLARE summa INTEGER = 0;
  DECLARE i_FOR1 INTEGER;
  DECLARE bound_i_FOR1 INTEGER;
  DECLARE n_FOR2 INTEGER;
  DECLARE bound_n_FOR2 INTEGER;  
BEGIN
  i_FOR1 = 1;
  bound_i_FOR1 = 3;
  WHILE (i_FOR1 <= bound_i_FOR1) DO
  BEGIN 
    n_FOR2 = 1;
    bound_n_FOR2 = 3;
    WHILE (n_FOR2 <= bound_n_FOR2) DO
    BEGIN 
      summa = :summa + :i_FOR1*:n_FOR2;
      n_FOR2 = n_FOR2 + 1;
    END    
    n_FOR2 = bound_n_FOR2;
    n_FOR2 = 3;
    bound_n_FOR2 = 1;
    WHILE (n_FOR2 >= bound_n_FOR2) DO
    BEGIN 
      summa = :summa + :i_FOR1*:n_FOR2;
      n_FOR2 = n_FOR2 - 1;
    END    
    n_FOR2 = bound_n_FOR2;
    i_FOR1 = i_FOR1 + 1;
  END
  i_FOR1 = bound_i_FOR1;
  i_FOR1 = 3;
  bound_i_FOR1 = 1;
  WHILE (i_FOR1 >= bound_i_FOR1) DO
  BEGIN 
    n_FOR2 = 1;
    bound_n_FOR2 = 3;
    WHILE (n_FOR2 <= bound_n_FOR2) DO
    BEGIN 
      summa = :summa + :i_FOR1*:n_FOR2;
      n_FOR2 = n_FOR2 + 1;
    END    
    n_FOR2 = bound_n_FOR2;
    n_FOR2 = 3;
    bound_n_FOR2 = 1;
    WHILE (n_FOR2 >= bound_n_FOR2) DO
    BEGIN 
      summa = :summa + :i_FOR1*:n_FOR2;
      n_FOR2 = n_FOR2 - 1;
    END    
    n_FOR2 = bound_n_FOR2;
    i_FOR1 = i_FOR1 - 1;
  END
  i_FOR1 = bound_i_FOR1;
END;

/* Функция */
CREATE FUNCTION F_Nested_Fors
RETURNS INTEGER
AS
  DECLARE summa INTEGER = 0;
  DECLARE i_FOR1 INTEGER;
  DECLARE bound_i_FOR1 INTEGER;
  DECLARE n_FOR2 INTEGER;
  DECLARE bound_n_FOR2 INTEGER;  
BEGIN
  i_FOR1 = 1;
  bound_i_FOR1 = 3;
  WHILE (i_FOR1 <= bound_i_FOR1) DO
  BEGIN 
    n_FOR2 = 1;
    bound_n_FOR2 = 3;
    WHILE (n_FOR2 <= bound_n_FOR2) DO
    BEGIN 
      summa = :summa + :i_FOR1*:n_FOR2;
      n_FOR2 = n_FOR2 + 1;
    END    
    n_FOR2 = bound_n_FOR2;
    n_FOR2 = 3;
    bound_n_FOR2 = 1;
    WHILE (n_FOR2 >= bound_n_FOR2) DO
    BEGIN 
      summa = :summa + :i_FOR1*:n_FOR2;
      n_FOR2 = n_FOR2 - 1;
    END    
    n_FOR2 = bound_n_FOR2;
    i_FOR1 = i_FOR1 + 1;
  END
  i_FOR1 = bound_i_FOR1;
  i_FOR1 = 3;
  bound_i_FOR1 = 1;
  WHILE (i_FOR1 >= bound_i_FOR1) DO
  BEGIN 
    n_FOR2 = 1;
    bound_n_FOR2 = 3;
    WHILE (n_FOR2 <= bound_n_FOR2) DO
    BEGIN 
      summa = :summa + :i_FOR1*:n_FOR2;
      n_FOR2 = n_FOR2 + 1;
    END    
    n_FOR2 = bound_n_FOR2;
    n_FOR2 = 3;
    bound_n_FOR2 = 1;
    WHILE (n_FOR2 >= bound_n_FOR2) DO
    BEGIN 
      summa = :summa + :i_FOR1*:n_FOR2;
      n_FOR2 = n_FOR2 - 1;
    END    
    n_FOR2 = bound_n_FOR2;
    i_FOR1 = i_FOR1 - 1;
  END
  i_FOR1 = bound_i_FOR1;
  RETURN summa;   -- 144
END; 

/* Пакет */
CREATE OR ALTER PACKAGE Pack_Nested_Fors
AS BEGIN
   FUNCTION PF_Nested_Fors
   RETURNS INTEGER;
   PROCEDURE PP_Nested_Fors; 
END; 

/* Тело пакета */
RECREATE PACKAGE BODY Pack_Nested_Fors
AS BEGIN
   FUNCTION PF_Nested_Fors
   RETURNS INTEGER
   AS
     DECLARE summa INTEGER = 0;
     DECLARE i_FOR1 INTEGER;
     DECLARE bound_i_FOR1 INTEGER;
     DECLARE n_FOR2 INTEGER;
     DECLARE bound_n_FOR2 INTEGER;  
   BEGIN
     i_FOR1 = 1;
     bound_i_FOR1 = 3;
     WHILE (i_FOR1 <= bound_i_FOR1) DO
     BEGIN 
       n_FOR2 = 1;
       bound_n_FOR2 = 3;
       WHILE (n_FOR2 <= bound_n_FOR2) DO
       BEGIN 
         summa = :summa + :i_FOR1*:n_FOR2;
         n_FOR2 = n_FOR2 + 1;
       END    
       n_FOR2 = bound_n_FOR2;
       n_FOR2 = 3;
       bound_n_FOR2 = 1;
       WHILE (n_FOR2 >= bound_n_FOR2) DO
       BEGIN 
         summa = :summa + :i_FOR1*:n_FOR2;
         n_FOR2 = n_FOR2 - 1;
       END    
       n_FOR2 = bound_n_FOR2;
       i_FOR1 = i_FOR1 + 1;
     END
     i_FOR1 = bound_i_FOR1;
     i_FOR1 = 3;
     bound_i_FOR1 = 1;
     WHILE (i_FOR1 >= bound_i_FOR1) DO
     BEGIN 
       n_FOR2 = 1;
       bound_n_FOR2 = 3;
       WHILE (n_FOR2 <= bound_n_FOR2) DO
       BEGIN 
         summa = :summa + :i_FOR1*:n_FOR2;
         n_FOR2 = n_FOR2 + 1;
       END    
       n_FOR2 = bound_n_FOR2;
       n_FOR2 = 3;
       bound_n_FOR2 = 1;
       WHILE (n_FOR2 >= bound_n_FOR2) DO
       BEGIN 
         summa = :summa + :i_FOR1*:n_FOR2;
         n_FOR2 = n_FOR2 - 1;
       END    
       n_FOR2 = bound_n_FOR2;
       i_FOR1 = i_FOR1 - 1;
     END
     i_FOR1 = bound_i_FOR1;
     RETURN summa;
   END

   PROCEDURE PP_Nested_Fors
   AS
     DECLARE summa INTEGER = 0;
     DECLARE i_FOR1 INTEGER;
     DECLARE bound_i_FOR1 INTEGER;
     DECLARE n_FOR2 INTEGER;
     DECLARE bound_n_FOR2 INTEGER;  
   BEGIN
     i_FOR1 = 1;
     bound_i_FOR1 = 3;
     WHILE (i_FOR1 <= bound_i_FOR1) DO
     BEGIN 
       n_FOR2 = 1;
       bound_n_FOR2 = 3;
       WHILE (n_FOR2 <= bound_n_FOR2) DO
       BEGIN 
         summa = :summa + :i_FOR1*:n_FOR2;
         n_FOR2 = n_FOR2 + 1;
       END    
       n_FOR2 = bound_n_FOR2;
       n_FOR2 = 3;
       bound_n_FOR2 = 1;
       WHILE (n_FOR2 >= bound_n_FOR2) DO
       BEGIN 
         summa = :summa + :i_FOR1*:n_FOR2;
         n_FOR2 = n_FOR2 - 1;
       END    
       n_FOR2 = bound_n_FOR2;
       i_FOR1 = i_FOR1 + 1;
     END
     i_FOR1 = bound_i_FOR1;
     i_FOR1 = 3;
     bound_i_FOR1 = 1;
     WHILE (i_FOR1 >= bound_i_FOR1) DO
     BEGIN 
       n_FOR2 = 1;
       bound_n_FOR2 = 3;
       WHILE (n_FOR2 <= bound_n_FOR2) DO
       BEGIN 
         summa = :summa + :i_FOR1*:n_FOR2;
         n_FOR2 = n_FOR2 + 1;
       END    
       n_FOR2 = bound_n_FOR2;
       n_FOR2 = 3;
       bound_n_FOR2 = 1;
       WHILE (n_FOR2 >= bound_n_FOR2) DO
       BEGIN 
         summa = :summa + :i_FOR1*:n_FOR2;
         n_FOR2 = n_FOR2 - 1;
       END    
       n_FOR2 = bound_n_FOR2;
       i_FOR1 = i_FOR1 - 1;
     END
     i_FOR1 = bound_i_FOR1;
   END
END; 

/* Триггер DML */
CREATE OR ALTER TRIGGER T_Nested_Fors
  AFTER INSERT 
  ON students
AS
  DECLARE summa INTEGER = 0;
  DECLARE i_FOR1 INTEGER;
  DECLARE bound_i_FOR1 INTEGER;
  DECLARE n_FOR2 INTEGER;
  DECLARE bound_n_FOR2 INTEGER;  
BEGIN
  i_FOR1 = 1;
  bound_i_FOR1 = 3;
  WHILE (i_FOR1 <= bound_i_FOR1) DO
  BEGIN 
    n_FOR2 = 1;
    bound_n_FOR2 = 3;
    WHILE (n_FOR2 <= bound_n_FOR2) DO
    BEGIN 
      summa = :summa + :i_FOR1*:n_FOR2;
      n_FOR2 = n_FOR2 + 1;
    END    
    n_FOR2 = bound_n_FOR2;
    n_FOR2 = 3;
    bound_n_FOR2 = 1;
    WHILE (n_FOR2 >= bound_n_FOR2) DO
    BEGIN 
      summa = :summa + :i_FOR1*:n_FOR2;
      n_FOR2 = n_FOR2 - 1;
    END    
    n_FOR2 = bound_n_FOR2;
    i_FOR1 = i_FOR1 + 1;
  END
  i_FOR1 = bound_i_FOR1;
  i_FOR1 = 3;
  bound_i_FOR1 = 1;
  WHILE (i_FOR1 >= bound_i_FOR1) DO
  BEGIN 
    n_FOR2 = 1;
    bound_n_FOR2 = 3;
    WHILE (n_FOR2 <= bound_n_FOR2) DO
    BEGIN 
      summa = :summa + :i_FOR1*:n_FOR2;
      n_FOR2 = n_FOR2 + 1;
    END    
    n_FOR2 = bound_n_FOR2;
    n_FOR2 = 3;
    bound_n_FOR2 = 1;
    WHILE (n_FOR2 >= bound_n_FOR2) DO
    BEGIN 
      summa = :summa + :i_FOR1*:n_FOR2;
      n_FOR2 = n_FOR2 - 1;
    END    
    n_FOR2 = bound_n_FOR2;
    i_FOR1 = i_FOR1 - 1;
  END
  i_FOR1 = bound_i_FOR1;
END;

/* Анонимный блок */
EXECUTE BLOCK 
AS
  DECLARE summa INTEGER = 0;
  DECLARE i_FOR1 INTEGER;
  DECLARE bound_i_FOR1 INTEGER;
  DECLARE n_FOR2 INTEGER;
  DECLARE bound_n_FOR2 INTEGER;  
BEGIN
  i_FOR1 = 1;
  bound_i_FOR1 = 3;
  WHILE (i_FOR1 <= bound_i_FOR1) DO
  BEGIN 
    n_FOR2 = 1;
    bound_n_FOR2 = 3;
    WHILE (n_FOR2 <= bound_n_FOR2) DO
    BEGIN 
      summa = :summa + :i_FOR1*:n_FOR2;
      n_FOR2 = n_FOR2 + 1;
    END    
    n_FOR2 = bound_n_FOR2;
    n_FOR2 = 3;
    bound_n_FOR2 = 1;
    WHILE (n_FOR2 >= bound_n_FOR2) DO
    BEGIN 
      summa = :summa + :i_FOR1*:n_FOR2;
      n_FOR2 = n_FOR2 - 1;
    END    
    n_FOR2 = bound_n_FOR2;
    i_FOR1 = i_FOR1 + 1;
  END
  i_FOR1 = bound_i_FOR1;
  i_FOR1 = 3;
  bound_i_FOR1 = 1;
  WHILE (i_FOR1 >= bound_i_FOR1) DO
  BEGIN 
    n_FOR2 = 1;
    bound_n_FOR2 = 3;
    WHILE (n_FOR2 <= bound_n_FOR2) DO
    BEGIN 
      summa = :summa + :i_FOR1*:n_FOR2;
      n_FOR2 = n_FOR2 + 1;
    END    
    n_FOR2 = bound_n_FOR2;
    n_FOR2 = 3;
    bound_n_FOR2 = 1;
    WHILE (n_FOR2 >= bound_n_FOR2) DO
    BEGIN 
      summa = :summa + :i_FOR1*:n_FOR2;
      n_FOR2 = n_FOR2 - 1;
    END    
    n_FOR2 = bound_n_FOR2;
    i_FOR1 = i_FOR1 - 1;
  END
  i_FOR1 = bound_i_FOR1;    
END;  -- 144