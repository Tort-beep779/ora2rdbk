/* Процедура */
CREATE PROCEDURE P_Nested_Fors
IS
  summa PLS_INTEGER := 0;
BEGIN
  FOR i IN 1..3, REVERSE 1..3 LOOP
    FOR n IN 1..3, REVERSE 1..3 LOOP
      summa := summa + i*n; 
    END LOOP;
  END LOOP;
END; 

/* Функция */
CREATE FUNCTION F_Nested_Fors
RETURN PLS_INTEGER
IS
  summa PLS_INTEGER := 0;
BEGIN
  FOR i IN 1..3, REVERSE 1..3 LOOP
    FOR n IN 1..3, REVERSE 1..3 LOOP
      summa := summa + i*n; 
    END LOOP;
  END LOOP;
  RETURN summa;   -- 144 на версии 23
END; 

/* Пакет */
CREATE OR REPLACE PACKAGE Pack_Nested_Fors
AS 
   FUNCTION PF_Nested_Fors
   RETURN PLS_INTEGER;
   PROCEDURE PP_Nested_Fors; 
END; 

/* Тело пакета */
CREATE OR REPLACE PACKAGE BODY Pack_Nested_Fors
AS 
   FUNCTION PF_Nested_Fors
   RETURN PLS_INTEGER
   IS
     summa PLS_INTEGER := 0;
   BEGIN
     FOR i IN 1..3, REVERSE 1..3 LOOP
       FOR n IN 1..3, REVERSE 1..3 LOOP
         summa := summa + i*n; 
       END LOOP;
     END LOOP;
     RETURN summa;
   END;

   PROCEDURE PP_Nested_Fors
   IS
     summa PLS_INTEGER := 0;
   BEGIN
     FOR i IN 1..3, REVERSE 1..3 LOOP
       FOR n IN 1..3, REVERSE 1..3 LOOP
         summa := summa + i*n; 
       END LOOP;
     END LOOP;
   END; 
END; 

/* Триггер DML */
CREATE OR REPLACE TRIGGER T_Nested_Fors
  AFTER INSERT 
  ON students
  FOR EACH ROW
DECLARE
  summa PLS_INTEGER := 0;
BEGIN
  FOR i IN 1..3, REVERSE 1..3 LOOP
    FOR n IN 1..3, REVERSE 1..3 LOOP
      summa := summa + i*n; 
    END LOOP;
  END LOOP;
END;

/* Анонимный блок */
DECLARE
  summa PLS_INTEGER := 0;
BEGIN
  FOR i IN 1..3, REVERSE 1..3 LOOP
    FOR n IN 1..3, REVERSE 1..3 LOOP
      summa := summa + i*n;    -- 144 на версии 23
    END LOOP;
  END LOOP;
END; 