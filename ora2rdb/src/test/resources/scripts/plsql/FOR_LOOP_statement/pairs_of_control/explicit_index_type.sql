/* Процедура */
CREATE PROCEDURE P_Explicit_Index
IS
  TYPE intvec_t IS TABLE OF PLS_INTEGER INDEX BY PLS_INTEGER;
  vec intvec_t := intvec_t(3 => 10, 1 => 11, 100 => 34);
  summa NUMBER(5,1) := 0;
BEGIN
  FOR n, m NUMBER(5,1) IN PAIRS OF vec
  LOOP
      summa := summa + m; 
  END LOOP;
END; 

/* Функция */
CREATE FUNCTION F_Explicit_Index
RETURN NUMBER
IS
  TYPE intvec_t IS TABLE OF PLS_INTEGER INDEX BY PLS_INTEGER;
  vec intvec_t := intvec_t(3 => 10, 1 => 11, 100 => 34);
  summa NUMBER(5,1) := 0;
BEGIN
  FOR n, m NUMBER(5,1) IN PAIRS OF vec
  LOOP
      summa := summa + m; 
  END LOOP;
  RETURN summa; 
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
     TYPE intvec_t IS TABLE OF PLS_INTEGER INDEX BY PLS_INTEGER;
     vec intvec_t := intvec_t(3 => 10, 1 => 11, 100 => 34);
     summa NUMBER(5,1) := 0;
   BEGIN
     FOR n, m NUMBER(5,1) IN PAIRS OF vec
     LOOP
       summa := summa + m; 
     END LOOP;
     RETURN summa;
   END;

   PROCEDURE PP_Explicit_Index
   IS
     TYPE intvec_t IS TABLE OF PLS_INTEGER INDEX BY PLS_INTEGER;
     vec intvec_t := intvec_t(3 => 10, 1 => 11, 100 => 34);
     summa NUMBER(5,1)  := 0;
   BEGIN
     FOR n, m NUMBER(5,1) IN PAIRS OF vec
     LOOP
       summa := summa + m; 
     END LOOP;
   END; 
END; 

/* Триггер DML */
CREATE OR REPLACE TRIGGER T_Explicit_Index
  AFTER INSERT 
  ON students
  FOR EACH ROW
DECLARE
  TYPE intvec_t IS TABLE OF PLS_INTEGER INDEX BY PLS_INTEGER;
  vec intvec_t := intvec_t(3 => 10, 1 => 11, 100 => 34);
  summa NUMBER(5,1)  := 0;
BEGIN
  FOR n, m NUMBER(5,1) IN PAIRS OF vec
  LOOP
      summa := summa + m; 
  END LOOP;
END;

/* Анонимный блок */
DECLARE
  TYPE intvec_t IS TABLE OF PLS_INTEGER INDEX BY PLS_INTEGER;
  vec intvec_t := intvec_t(3 => 10, 1 => 11, 100 => 34);
  summa NUMBER(5,1) := 0;
BEGIN
  FOR n, m NUMBER(5,1) IN PAIRS OF vec
  LOOP
      summa := summa + m; 
  END LOOP;
END; 
