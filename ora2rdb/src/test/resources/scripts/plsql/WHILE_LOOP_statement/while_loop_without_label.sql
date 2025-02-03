/* Процедура */
CREATE PROCEDURE P_While
IS
  done BOOLEAN := FALSE;
  res VARCHAR2(50) := '';
BEGIN
  WHILE done LOOP
    res := 'This line does not print.';
  END LOOP;
  WHILE (NOT done) LOOP
    done := TRUE;
    res := 'Hello, world!';
  END LOOP;
  WHILE NOT done LOOP
    res := 'This line does not print.';
  END LOOP;
END; 

/* Функция */
CREATE FUNCTION F_While
RETURN VARCHAR2
IS
  done BOOLEAN := FALSE;
  res VARCHAR2(50) := '';
BEGIN
  WHILE done LOOP
    res := 'This line does not print.';
  END LOOP;
  WHILE (NOT done) LOOP
    done := TRUE;
    res := 'Hello, world!';
  END LOOP;
  WHILE NOT done LOOP
    res := 'This line does not print.';
  END LOOP;
  RETURN res;
END; 

/* Пакет */
CREATE OR REPLACE PACKAGE Pack_While
AS 
   FUNCTION PF_While 
   RETURN VARCHAR2;
   PROCEDURE PP_While; 
END Pack_While; 

/* Тело пакета */
CREATE OR REPLACE PACKAGE BODY Pack_While
AS 
   FUNCTION PF_While 
   RETURN VARCHAR2
   IS
     done BOOLEAN := FALSE;
     res VARCHAR2(50) := '';
   BEGIN
     WHILE done LOOP
       res := 'This line does not print.';
     END LOOP;
     WHILE (NOT done) LOOP
       done := TRUE;
       res := 'Hello, world!';
     END LOOP;
     WHILE NOT done LOOP
       res := 'This line does not print.';
     END LOOP;
     RETURN res;
   END;

   PROCEDURE PP_While
   IS
     done BOOLEAN := FALSE;
     res VARCHAR2(50) := '';
   BEGIN
     WHILE done LOOP
       res := 'This line does not print.';
     END LOOP;
     WHILE (NOT done) LOOP
       done := TRUE;
       res := 'Hello, world!';
     END LOOP;
     WHILE NOT done LOOP
       res := 'This line does not print.';
     END LOOP;
   END; 
END Pack_While; 

/* Триггер DML */
CREATE OR REPLACE TRIGGER T_While
  AFTER INSERT 
  ON students
  FOR EACH ROW
DECLARE
  done BOOLEAN := FALSE;
  res  VARCHAR2(50) := '';
BEGIN
  WHILE done LOOP
    res := 'This line does not print.';
  END LOOP;
  WHILE (NOT done) LOOP
    done := TRUE;
    res := 'Hello, world!';
  END LOOP;
  WHILE NOT done LOOP
    res := 'This line does not print.';
  END LOOP;
END T_While;

/* Анонимный блок */
DECLARE
  done BOOLEAN := FALSE;
  res  VARCHAR2(50) := '';
BEGIN
  WHILE done LOOP
    res := 'This line does not print.';
  END LOOP;
  WHILE (NOT done) LOOP
    done := TRUE;
    res := 'Hello, world!';
  END LOOP;
  WHILE NOT done LOOP
    res := 'This line does not print.';
  END LOOP;
END; 