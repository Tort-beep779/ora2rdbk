CREATE OR REPLACE TRIGGER T_For_With_When
  AFTER INSERT 
  ON students
  FOR EACH ROW
DECLARE
  summa PLS_INTEGER := 0;
BEGIN
  FOR power IN 2, REPEAT power*2 WHEN MOD(power, 32)= 0 
  LOOP
    if power > 64 then exit; end if;
    summa := summa + power;
  END LOOP;
END;