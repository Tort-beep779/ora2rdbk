CREATE OR REPLACE TRIGGER T_Grade_meaning1
  AFTER INSERT
  ON students
  FOR EACH ROW
DECLARE
    I NUMBER;
BEGIN
    I := 0;
    LOOP
        I := I + 1;
        EXIT WHEN (I > 5);
    END LOOP;
END T_Grade_meaning1;