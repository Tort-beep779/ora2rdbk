CREATE OR REPLACE TRIGGER T_Grade_meaning1
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
   END IF;
   IF (degree < 10) AND (degree >=5) THEN
      res := 'Low';
      pass := 'F';
   END IF;
   IF (degree < 5) THEN
      res := 'Too low';
   END IF;
END T_Grade_meaning1;