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