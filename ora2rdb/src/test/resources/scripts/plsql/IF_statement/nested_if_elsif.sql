/* Процедура */
CREATE PROCEDURE P_Grade_meaning7(score NUMERIC, subject VARCHAR2)
IS 
  pass BOOLEAN := TRUE;
  res  CHAR(15) := '';
BEGIN
    IF score > 50 THEN
        IF subject = 'Математика' THEN
            res := 'Good';
            pass := TRUE;
        ELSIF subject = 'Физика' THEN
            res := 'Good';
            pass := TRUE;
        ELSIF subject = 'Информатика' THEN
            res := 'Good';
            pass := TRUE;
        END IF;
    ELSE
        IF subject = 'Математика' THEN
            res := 'Poor';
            pass := FALSE;
        ELSIF subject = 'Физика' THEN
            res := 'Poor';
            pass := FALSE;
        END IF;
    END IF;
END;

/* Функция */
CREATE FUNCTION P_Grade_meaning7 (score NUMERIC, subject VARCHAR2)
RETURN VARCHAR2
IS
  pass BOOLEAN := TRUE;
  res  CHAR(15) := '';
BEGIN
    IF score > 50 THEN
        IF subject = 'Математика' THEN
            res := 'Good';
            pass := TRUE;
        ELSIF subject = 'Физика' THEN
            res := 'Good';
            pass := TRUE;
        ELSIF subject = 'Информатика' THEN
            res := 'Good';
            pass := TRUE;
        END IF;
    ELSE
        IF subject = 'Математика' THEN
            res := 'Poor';
            pass := FALSE;
        ELSIF subject = 'Физика' THEN
            res := 'Poor';
            pass := FALSE;
        END IF;
    END IF;
    RETURN res;
END; 

/* Пакет */
CREATE OR REPLACE PACKAGE Pack_Grade_meaning7
AS 
   FUNCTION PF_Grade_meaning7 (score NUMERIC, subject VARCHAR2) 
   RETURN VARCHAR2;
   PROCEDURE PP_Grade_meaning7 (score NUMERIC, subject VARCHAR2); 
END Pack_Grade_meaning7; 

/* Тело пакета */
CREATE OR REPLACE PACKAGE BODY Pack_Grade_meaning7
AS 
   FUNCTION PF_Grade_meaning7 (score NUMERIC, subject VARCHAR2) 
   RETURN VARCHAR2
   IS
     pass BOOLEAN := TRUE;
     res  CHAR(15) := '';
   BEGIN
     IF score > 50 THEN
        IF subject = 'Математика' THEN
            res := 'Good';
            pass := TRUE;
        ELSIF subject = 'Физика' THEN
            res := 'Good';
            pass := TRUE;
        ELSIF subject = 'Информатика' THEN
            res := 'Good';
            pass := TRUE;
        END IF;
     ELSE
        IF subject = 'Математика' THEN
            res := 'Poor';
            pass := FALSE;
        ELSIF subject = 'Физика' THEN
            res := 'Poor';
            pass := FALSE;
        END IF;
     END IF;
     RETURN res;
   END; 

   PROCEDURE PP_Grade_meaning7(score NUMERIC, subject VARCHAR2)
   IS 
     pass BOOLEAN := TRUE;
     res  CHAR(15) := '';
   BEGIN
     IF score > 50 THEN
        IF subject = 'Математика' THEN
            res := 'Good';
            pass := TRUE;
        ELSIF subject = 'Физика' THEN
            res := 'Good';
            pass := TRUE;
        ELSIF subject = 'Информатика' THEN
            res := 'Good';
            pass := TRUE;
        END IF;
     ELSE
        IF subject = 'Математика' THEN
            res := 'Poor';
            pass := FALSE;
        ELSIF subject = 'Физика' THEN
            res := 'Poor';
            pass := FALSE;
        END IF;
     END IF;
   END;
END Pack_Grade_meaning7; 

/* Триггер DML */
CREATE OR REPLACE TRIGGER T_Grade_meaning7
  AFTER INSERT 
  ON students
  FOR EACH ROW
DECLARE
    score NUMERIC;
    pass CHAR(1) := 'T';
    res  CHAR(15) := '';
    subject VARCHAR2(50) := 'Математика';
BEGIN
   score := :NEW.score;
   IF score > 50 THEN
      IF subject = 'Математика' THEN
          res := 'Good';
          pass := 'T';
      ELSIF subject = 'Физика' THEN
          res := 'Good';
          pass := 'T';
      ELSIF subject = 'Информатика' THEN
          res := 'Good';
          pass := 'T';
      END IF;
   ELSE
      IF subject = 'Математика' THEN
          res := 'Poor';
          pass := 'F';
      ELSIF subject = 'Физика' THEN
          res := 'Poor';
          pass := 'F';
      END IF;
   END IF;        
END T_Grade_meaning7;

/* Анонимный блок */
DECLARE
   pass BOOLEAN := TRUE;
   res  CHAR(15) := '';
   score NUMERIC := '40';
   subject VARCHAR2(50) := 'Математика';
BEGIN
   IF score > 50 THEN
      IF subject = 'Математика' THEN
          res := 'Good';
          pass := TRUE;
      ELSIF subject = 'Физика' THEN
          res := 'Good';
          pass := TRUE;
      ELSIF subject = 'Информатика' THEN
          res := 'Good';
          pass := TRUE;
      END IF;
   ELSE
      IF subject = 'Математика' THEN
          res := 'Poor';
          pass := FALSE;
      ELSIF subject = 'Физика' THEN
          res := 'Poor';
          pass := FALSE;
      END IF;
   END IF;    
END; 