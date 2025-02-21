/* Процедура */
CREATE PROCEDURE P_For_With_Step
IS
  summa PLS_INTEGER := 0;
BEGIN
  FOR i IN 3..9 BY 3, REVERSE 5..15 BY 5 
  LOOP
    summa := summa + i;
  END LOOP;
END; 

/* Функция */
CREATE FUNCTION F_For_With_Step
RETURN PLS_INTEGER
IS
  summa PLS_INTEGER := 0;
BEGIN
  FOR i IN 3..9 BY 3, REVERSE 5..15 BY 5 
  LOOP
      summa := summa + i;
  END LOOP;
  RETURN summa;  -- 48
END; 

/* Пакет */
CREATE OR REPLACE PACKAGE Pack_For_With_Step
AS 
   FUNCTION PF_For_With_Step
   RETURN PLS_INTEGER;
   PROCEDURE PP_For_With_Step; 
END; 

/* Тело пакета */
CREATE OR REPLACE PACKAGE BODY Pack_For_With_Step
AS 
   FUNCTION PF_For_With_Step
   RETURN PLS_INTEGER
   IS
     summa PLS_INTEGER := 0;
   BEGIN
     FOR i IN 3..9 BY 3, REVERSE 5..15 BY 5 
     LOOP
       summa := summa + i;
     END LOOP;
     RETURN summa;
   END;

   PROCEDURE PP_For_With_Step
   IS
     summa PLS_INTEGER := 0;
   BEGIN
     FOR i IN 3..9 BY 3, REVERSE 5..15 BY 5 
     LOOP
       summa := summa + i;
     END LOOP;
   END; 
END; 

/* Триггер DML */
CREATE OR REPLACE TRIGGER T_For_With_Step
  AFTER INSERT 
  ON students
  FOR EACH ROW
DECLARE
  summa PLS_INTEGER := 0;
BEGIN
  FOR i IN 3..9 BY 3, REVERSE 5..15 BY 5 
  LOOP
      summa := summa + i;
  END LOOP;
END;

/* Анонимный блок */
DECLARE
  summa PLS_INTEGER := 0;
BEGIN
  FOR i IN 3..9 BY 3, REVERSE 5..15 BY 5 
  LOOP
      summa := summa + i; -- 48
  END LOOP;
END; 