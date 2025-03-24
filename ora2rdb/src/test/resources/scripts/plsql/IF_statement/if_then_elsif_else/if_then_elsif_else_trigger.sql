CREATE OR REPLACE TRIGGER T_Grade_meaning5
  AFTER INSERT 
  ON students
  FOR EACH ROW
DECLARE
    grade CHAR;
    pass CHAR(1) := 'T';
    res  CHAR(15) := '';
BEGIN
   grade := :NEW.mark;
   IF grade = 'A' THEN
     res := 'Excellent';
     pass := 'T';
   ELSIF (grade = 'B') THEN
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
   ELSE
     res := 'Error';
     pass := 'F';
   END IF;
END T_Grade_meaning5;