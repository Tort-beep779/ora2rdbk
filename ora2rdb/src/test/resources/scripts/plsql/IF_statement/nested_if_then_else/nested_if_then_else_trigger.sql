CREATE OR REPLACE TRIGGER T_Grade_meaning6
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
   ELSE 
     IF (grade = 'B') THEN
       res := 'Very Good';
       pass := 'T';
     ELSE
       IF grade = 'C' THEN
         res := 'Good';
         pass := 'T';
       ELSE
         IF grade = 'D' THEN
           res := 'Fair';
           pass := 'F';
         ELSE 
           IF grade = 'F' THEN
             res := 'Poor';
             pass := 'F';
           ELSE
             res := 'Error';
             pass := 'F';
           END IF;
         END IF;
       END IF;
     END IF;
   END IF;        
END T_Grade_meaning6;