/* Процедура */
CREATE PROCEDURE P_Explicit_Index
IS
  summa NUMBER(5,1) := 0;
BEGIN
  FOR n NUMBER(5,1) IN REVERSE 1.0 .. 3.0 BY 0.5 
  LOOP
      summa := summa + n;
  END LOOP;
END; 

/* Функция */
CREATE FUNCTION F_Explicit_Index
RETURN NUMBER
IS
  summa NUMBER(5,1) := 0;
BEGIN
  FOR n NUMBER(5,1) IN REVERSE 1.0 .. 3.0 BY 0.5 
  LOOP
      summa := summa + n;
  END LOOP;
  RETURN summa;  -- 10
END; 

/* Пакет */
CREATE OR REPLACE PACKAGE Pack_Explicit_Index
AS 
   FUNCTION PF_Explicit_Index
   RETURN NUMBER;
   PROCEDURE PP_Explicit_Index; 
END; 

/* Тело пакета */
CREATE OR REPLACE PACKAGE BODY Pack_Explicit_Index
AS 
   FUNCTION PF_Explicit_Index
   RETURN NUMBER
   IS
     summa NUMBER(5,1) := 0;
   BEGIN
     FOR n NUMBER(5,1) IN REVERSE 1.0 .. 3.0 BY 0.5 
     LOOP
       summa := summa + n;
     END LOOP;
     RETURN summa;
   END;

   PROCEDURE PP_Explicit_Index
   IS
     summa NUMBER(5,1) := 0;
   BEGIN
     FOR n NUMBER(5,1) IN REVERSE 1.0 .. 3.0 BY 0.5 
     LOOP
       summa := summa + n;
     END LOOP;
   END; 
END; 

/* Триггер DML */
CREATE OR REPLACE TRIGGER T_Explicit_Index
  AFTER INSERT 
  ON students
  FOR EACH ROW
DECLARE
  summa NUMBER(5,1) := 0;
BEGIN
  FOR n NUMBER(5,1) IN REVERSE 1.0 .. 3.0 BY 0.5 
  LOOP
      summa := summa + n;
  END LOOP;
END;

/* Анонимный блок */
DECLARE
  summa NUMBER(5,1) := 0;
BEGIN
  FOR n NUMBER(5,1) IN REVERSE 1.0 .. 3.0 BY 0.5 
  LOOP
      summa := summa + n; -- 10
  END LOOP;
END; 