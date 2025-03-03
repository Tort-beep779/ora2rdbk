CREATE OR REPLACE TRIGGER T_For_With_While_and_When
  AFTER INSERT 
  ON students
  FOR EACH ROW
DECLARE
  summa PLS_INTEGER := 0;
BEGIN
  FOR power IN 2, REPEAT power*2 WHILE power <= 64 WHEN MOD(power, 32)= 0 
  LOOP
      summa := summa + power;
  END LOOP;
END;