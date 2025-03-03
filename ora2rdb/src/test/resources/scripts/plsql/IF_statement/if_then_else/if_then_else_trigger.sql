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