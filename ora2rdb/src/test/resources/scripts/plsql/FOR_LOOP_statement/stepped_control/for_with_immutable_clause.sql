/* Процедура */
CREATE PROCEDURE P_For_With_Immutable_Index
IS
  summa PLS_INTEGER := 0;
BEGIN
  FOR i IMMUTABLE IN 1..3 LOOP
      summa := summa + i;
  END LOOP;
END; 

/* Функция */
CREATE FUNCTION F_For_With_Immutable_Index
RETURN PLS_INTEGER
IS
  summa PLS_INTEGER := 0;
BEGIN
  FOR i IMMUTABLE IN 1..3 LOOP
      summa := summa + i;
  END LOOP;
  RETURN summa;  -- 6
END; 

/* Пакет */
CREATE OR REPLACE PACKAGE Pack_For_With_Immutable_Index
AS 
   FUNCTION PF_For_With_Immutable_Index
   RETURN PLS_INTEGER;
   PROCEDURE PP_For_With_Immutable_Index; 
END; 

/* Тело пакета */
CREATE OR REPLACE PACKAGE BODY Pack_For_With_Immutable_Index
AS 
   FUNCTION PF_For_With_Immutable_Index
   RETURN PLS_INTEGER
   IS
     summa PLS_INTEGER := 0;
   BEGIN
     FOR i IMMUTABLE IN 1..3 LOOP
       summa := summa + i;
     END LOOP;
     RETURN summa;
   END; 

   PROCEDURE PP_For_With_Immutable_Index
   IS
     summa PLS_INTEGER := 0;
   BEGIN
     FOR i IMMUTABLE IN 1..3 LOOP
       summa := summa + i;
     END LOOP;
   END; 
END; 

/* Триггер DML */
CREATE OR REPLACE TRIGGER T_For_With_Immutable_Index
  AFTER INSERT 
  ON students
  FOR EACH ROW
DECLARE
  summa PLS_INTEGER := 0;
BEGIN
  FOR i IMMUTABLE IN 1..3 LOOP
      summa := summa + i;
  END LOOP;
END; 

/* Анонимный блок */
DECLARE
  summa PLS_INTEGER := 0;
BEGIN
  FOR i IMMUTABLE IN 1..3 LOOP
      summa := summa + i;   
  END LOOP;
END; 