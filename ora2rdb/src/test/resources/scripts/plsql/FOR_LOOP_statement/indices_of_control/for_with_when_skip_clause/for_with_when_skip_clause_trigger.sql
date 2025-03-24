CREATE OR REPLACE TRIGGER T_For_With_When
  AFTER INSERT 
  ON students
  FOR EACH ROW
DECLARE
  TYPE nesttabl_t IS TABLE OF VARCHAR2(15);
  vec nesttabl_t := nesttabl_t('John', 'Mary', 'Alberto', 'Juanita');
  summa PLS_INTEGER := 0;
BEGIN
  FOR i IN INDICES OF vec WHEN i != 2
  LOOP
     summa := summa + i;
  END LOOP;
END;