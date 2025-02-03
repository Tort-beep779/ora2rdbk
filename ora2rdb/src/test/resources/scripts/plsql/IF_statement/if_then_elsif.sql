/* Процедура */
CREATE PROCEDURE P_Grade_meaning3(grade CHAR, res OUT CHAR)
IS
  pass BOOLEAN := FALSE;
BEGIN
    res := '';
    IF grade = 'A' THEN
      res := 'Excellent';
      pass := TRUE;
    ELSIF grade = 'B' THEN
      res := 'Very Good';
      pass := TRUE;
    ELSIF grade = 'C' THEN
      res := 'Good';
      pass := TRUE;
    ELSIF grade = 'D' THEN
      res := 'Fair';
      pass := FALSE;
    ELSIF grade = 'F' THEN
      res := 'Poor';
      pass := FALSE;
    END IF;
END; 

/* Функция */
CREATE FUNCTION F_Grade_meaning3 (grade CHAR)
RETURN VARCHAR2
IS
  pass BOOLEAN := FALSE;
  res  CHAR(15) := '';
BEGIN
    IF grade = 'A' THEN
      res := 'Excellent';
      pass := TRUE;
    ELSIF grade = 'B' THEN
      res := 'Very Good';
      pass := TRUE;
    ELSIF grade = 'C' THEN
      res := 'Good';
      pass := TRUE;
    ELSIF grade = 'D' THEN
      res := 'Fair';
      pass := FALSE;
    ELSIF grade = 'F' THEN
      res := 'Poor';
      pass := FALSE;
    END IF;
    RETURN res;
END; 

/* Пакет */
CREATE OR REPLACE PACKAGE Pack_Grade_meaning3
AS 
   FUNCTION PF_Grade_meaning3 (grade CHAR) 
   RETURN VARCHAR2;
   PROCEDURE PP_Grade_meaning3(grade CHAR, res OUT CHAR); 
END Pack_Grade_meaning3; 

/* Тело пакета */
CREATE OR REPLACE PACKAGE BODY Pack_Grade_meaning3
AS 
   FUNCTION PF_Grade_meaning3 (grade CHAR) 
   RETURN VARCHAR2
   IS
     pass BOOLEAN := FALSE;
     res  CHAR(15) := '';
   BEGIN
       IF grade = 'A' THEN
         res := 'Excellent';
         pass := TRUE;
       ELSIF grade = 'B' THEN
         res := 'Very Good';
         pass := TRUE;
       ELSIF grade = 'C' THEN
         res := 'Good';
         pass := TRUE;
       ELSIF grade = 'D' THEN
         res := 'Fair';
         pass := FALSE;
       ELSIF grade = 'F' THEN
         res := 'Poor';
         pass := FALSE;
       END IF;
       RETURN res;
   END; 

   PROCEDURE PP_Grade_meaning3(grade CHAR, res OUT CHAR)
   IS
     pass BOOLEAN := FALSE;
   BEGIN
       res := '';
       IF grade = 'A' THEN
         res := 'Excellent';
         pass := TRUE;
       ELSIF grade = 'B' THEN
         res := 'Very Good';
         pass := TRUE;
       ELSIF grade = 'C' THEN
         res := 'Good';
         pass := TRUE;
       ELSIF grade = 'D' THEN
         res := 'Fair';
         pass := FALSE;
       ELSIF grade = 'F' THEN
         res := 'Poor';
         pass := FALSE;
       END IF;
   END; 
END Pack_Grade_meaning3; 

/* Триггер DML */
CREATE OR REPLACE TRIGGER T_Grade_meaning3
  AFTER INSERT 
  ON students
  FOR EACH ROW
DECLARE
    grade CHAR(1);
    pass CHAR(1) := 'F';
    res  CHAR(15) := '';
BEGIN
   grade := :NEW.mark;
   IF grade = 'A' THEN
     res := 'Excellent';
     pass := 'T';
   ELSIF grade = 'B' THEN
     res := 'Very Good';
     pass := 'T';
   ELSIF grade = 'C' THEN
     res := 'Good';
     pass := 'T';
   ELSIF grade = 'D' THEN
     res := 'Fair';
     pass := 'F';
   ELSIF grade = 'F' THEN
     res := 'Poor';
     pass := 'F';
   END IF;
END T_Grade_meaning3;

/* Анонимный блок */
DECLARE
   pass BOOLEAN := FALSE;
   res  CHAR(15) := '';
   grade  CHAR(1) := 'B';
BEGIN
    IF grade = 'A' THEN
      res := 'Excellent';
      pass := TRUE;
    ELSIF grade = 'B' THEN
      res := 'Very Good';
      pass := TRUE;
    ELSIF grade = 'C' THEN
      res := 'Good';
      pass := TRUE;
    ELSIF grade = 'D' THEN
      res := 'Fair';
      pass := FALSE;
    ELSIF grade = 'F' THEN
      res := 'Poor';
      pass := FALSE;
    END IF;
END; 