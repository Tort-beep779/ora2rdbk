/* Процедура */
CREATE PROCEDURE P_Few_Fors
IS
  summa PLS_INTEGER := 0;  
BEGIN
  FOR i IN 1..3 LOOP
      summa := summa + i;
  END LOOP;
  FOR i IN 50..53 LOOP
      summa := summa + i;
  END LOOP;
END; 

/* Функция */
CREATE FUNCTION F_Few_Fors
RETURN PLS_INTEGER
IS
  summa PLS_INTEGER := 0;  
BEGIN
  FOR i IN 1..3 LOOP
      summa := summa + i;
  END LOOP;
  FOR i IN 50..53 LOOP
      summa := summa + i;
  END LOOP;
  RETURN summa;  -- 212
END; 

/* Пакет */
CREATE OR REPLACE PACKAGE Pack_Few_Fors
AS 
   FUNCTION PF_Few_Fors 
   RETURN PLS_INTEGER;
   PROCEDURE PP_Few_Fors; 
END; 

/* Тело пакета */
CREATE OR REPLACE PACKAGE BODY Pack_Few_Fors
AS 
   FUNCTION PF_Few_Fors
   RETURN PLS_INTEGER
   IS
     summa PLS_INTEGER := 0;     
   BEGIN
     FOR i IN 1..3 LOOP
       summa := summa + i; 
     END LOOP;
     FOR i IN 50..53 LOOP
       summa := summa + i; 
     END LOOP;
     RETURN summa;
   END;

   PROCEDURE PP_Few_Fors
   IS
     summa PLS_INTEGER := 0;     
   BEGIN
     FOR i IN 1..3 LOOP
       summa := summa + i; 
     END LOOP;
     FOR i IN 50..53 LOOP
      summa := summa + i;
     END LOOP;
   END; 
END; 

/* Триггер DML */
CREATE OR REPLACE TRIGGER T_Few_Fors
  AFTER INSERT 
  ON students
  FOR EACH ROW
DECLARE
  summa PLS_INTEGER := 0;  
BEGIN
  FOR i IN 1..3 LOOP
      summa := summa + i;
  END LOOP;
  FOR i IN 50..53 LOOP
      summa := summa + i;
  END LOOP;
END;

/* Анонимный блок */
DECLARE
  summa PLS_INTEGER := 0;  
BEGIN
  FOR i IN 1..3 LOOP
      summa := summa + i;
  END LOOP;
  FOR i IN 50..53 LOOP
      summa := summa + i;
  END LOOP;
END; 