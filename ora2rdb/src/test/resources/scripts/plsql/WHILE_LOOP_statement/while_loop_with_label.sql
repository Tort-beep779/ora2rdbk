/* Процедура */
CREATE PROCEDURE P_While_Label
IS
  done BOOLEAN := FALSE;
  res VARCHAR2(50) := '';
BEGIN
  <<loopA>>
  WHILE (NOT done) LOOP
    done := TRUE;
    res := 'Hello, world!';
  END LOOP loopA;
END; 

/* Функция */
CREATE FUNCTION F_While_Label
RETURN VARCHAR2
IS
  done BOOLEAN := FALSE;
  res VARCHAR2(50) := '';
BEGIN
  <<loopA>>
  WHILE (NOT done) LOOP
    done := TRUE;
    res := 'Hello, world!';
  END LOOP loopA;
  RETURN res;
END; 

/* Пакет */
CREATE OR REPLACE PACKAGE Pack_While_Label
AS 
   FUNCTION PF_While_Label 
   RETURN VARCHAR2;
   PROCEDURE PP_While_Label; 
END Pack_While_Label; 

/* Тело пакета */
CREATE OR REPLACE PACKAGE BODY Pack_While_Label
AS 
   FUNCTION PF_While_Label 
   RETURN VARCHAR2
   IS
     done BOOLEAN := FALSE;
     res VARCHAR2(50) := '';
   BEGIN
     <<loopA>>
     WHILE (NOT done) LOOP
       done := TRUE;
       res := 'Hello, world!';
     END LOOP loopA;
     RETURN res;
   END;

   PROCEDURE PP_While_Label
   IS
     done BOOLEAN := FALSE;
     res VARCHAR2(50) := '';
   BEGIN
     <<loopA>>
     WHILE (NOT done) LOOP
       done := TRUE;
       res := 'Hello, world!';
     END LOOP loopA;
   END; 
END Pack_While_Label; 

/* Триггер DML */
CREATE OR REPLACE TRIGGER T_While_Label
  AFTER INSERT 
  ON students
  FOR EACH ROW
DECLARE
  done BOOLEAN := FALSE;
  res  VARCHAR2(50) := '';
BEGIN
  <<loopA>>
  WHILE (NOT done) LOOP
    done := TRUE;
    res := 'Hello, world!';
  END LOOP loopA;
END T_While_Label;

/* Анонимный блок */
DECLARE
  done BOOLEAN := FALSE;
  res  VARCHAR2(50) := '';
BEGIN
  <<loopA>>
  WHILE (NOT done) LOOP
    done := TRUE;
    res := 'Hello, world!';
  END LOOP loopA;
END; 