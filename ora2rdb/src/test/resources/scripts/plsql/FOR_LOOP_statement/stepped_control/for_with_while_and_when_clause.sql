/* Процедура */
CREATE PROCEDURE P_For_With_While_and_When
IS
  summa PLS_INTEGER := 0;
BEGIN
  FOR i IN 1..10 WHILE i < 5 WHEN i != 2 
  LOOP
      summa := summa + i;
  END LOOP;
END; 

/* Функция */
CREATE FUNCTION F_For_With_While_and_When
RETURN PLS_INTEGER
IS
  summa PLS_INTEGER := 0;
BEGIN
  FOR i IN 1..10 WHILE i < 5 WHEN i != 2 
  LOOP
      summa := summa + i;
  END LOOP;
  RETURN summa;  -- 8
END; 

/* Пакет */
CREATE OR REPLACE PACKAGE Pack_For_With_While_and_When
AS 
   FUNCTION PF_For_With_While_and_When
   RETURN PLS_INTEGER;
   PROCEDURE PP_For_With_While_and_When; 
END; 

/* Тело пакета */
CREATE OR REPLACE PACKAGE BODY Pack_For_With_While_and_When
AS 
   FUNCTION PF_For_With_While_and_When
   RETURN PLS_INTEGER
   IS
     summa PLS_INTEGER := 0;
   BEGIN
     FOR i IN 1..10 WHILE i < 5 WHEN i != 2 
     LOOP
      summa := summa + i;
     END LOOP;
     RETURN summa;
   END;

   PROCEDURE PP_For_With_While_and_When
   IS
     summa PLS_INTEGER := 0;
   BEGIN
     FOR i IN 1..10 WHILE i < 5 WHEN i != 2 
     LOOP
      summa := summa + i;
     END LOOP;
   END; 
END; 

/* Триггер DML */
CREATE OR REPLACE TRIGGER T_For_With_While_and_When
  AFTER INSERT 
  ON students
  FOR EACH ROW
DECLARE
  summa PLS_INTEGER := 0;
BEGIN
  FOR i IN 1..10 WHILE i < 5 WHEN i != 2 
  LOOP
      summa := summa + i;
  END LOOP;
END;

/* Анонимный блок */
DECLARE
  summa PLS_INTEGER := 0;
BEGIN
  FOR i IN 1..10 WHILE i < 5 WHEN i != 2 
  LOOP
      summa := summa + i;  -- 8
  END LOOP;
END; 