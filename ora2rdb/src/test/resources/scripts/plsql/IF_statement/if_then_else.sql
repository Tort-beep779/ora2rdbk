/* Процедура */
CREATE PROCEDURE P_Grade_meaning2 (degree INTEGER, res OUT CHAR)
IS
  pass BOOLEAN := FALSE;
BEGIN
    res := '';
    IF degree > 10 THEN
      res := 'Good';
      pass := TRUE;
    ELSE 
      res := 'Low';
      pass := FALSE;
    END IF;
END; 

/* Функция */
CREATE FUNCTION F_Grade_meaning2 (degree INTEGER)
RETURN VARCHAR2
IS
  pass BOOLEAN := FALSE;
  res  CHAR(15) := '';
BEGIN
    IF degree > 10 THEN
      res := 'Good';
      pass := TRUE;
    ELSE 
      res := 'Low';
      pass := FALSE;
    END IF;
    RETURN res;
END; 

/* Пакет */
CREATE OR REPLACE PACKAGE Pack_Grade_meaning2
AS 
   FUNCTION PF_Grade_meaning2 (degree INTEGER) 
   RETURN VARCHAR2;
   PROCEDURE PP_Grade_meaning2 (degree INTEGER, res OUT CHAR); 
END Pack_Grade_meaning2; 

/* Тело пакета */
CREATE OR REPLACE PACKAGE BODY Pack_Grade_meaning2
AS 
   FUNCTION PF_Grade_meaning2 (degree INTEGER) 
   RETURN VARCHAR2
   IS
     pass BOOLEAN := FALSE;
     res  CHAR(15) := '';
   BEGIN
       IF degree > 10 THEN
         res := 'Good';
         pass := TRUE;
       ELSE 
         res := 'Low';
         pass := FALSE;
       END IF;
       RETURN res;
   END; 

   PROCEDURE PP_Grade_meaning2 (degree INTEGER, res OUT CHAR)
   IS
     pass BOOLEAN := TRUE;
   BEGIN
       res := '';
       IF degree > 10 THEN
         res := 'Good';
         pass := TRUE;
       ELSE 
         res := 'Low';
         pass := FALSE;
       END IF;
   END; 
END Pack_Grade_meaning2; 

/* Триггер DML */
CREATE OR REPLACE TRIGGER T_Grade_meaning2
  AFTER INSERT 
  ON students
  FOR EACH ROW
DECLARE
    degree INTEGER;
    pass CHAR(1) := 'F';
    res  CHAR(15) := '';
BEGIN
   degree := :NEW.mark;
   IF degree > 10 THEN
     res := 'Good';
     pass := 'T';
   ELSE 
      res := 'Low';
      pass := FALSE;
   END IF;
END T_Grade_meaning2;

/* Анонимный блок */
DECLARE
   pass BOOLEAN := FALSE;
   res  CHAR(15) := '';
   degree INTEGER:= 14;
BEGIN
    IF degree > 10 THEN
      res := 'Good';
      pass := TRUE;
    ELSE 
      res := 'Low';
      pass := FALSE;
    END IF;
END; 