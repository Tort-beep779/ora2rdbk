CREATE PROCEDURE P_For_With_When
IS
  TYPE nesttabl_t IS TABLE OF VARCHAR2(15);
  vec nesttabl_t := nesttabl_t('John', 'Mary', 'Alberto', 'Juanita');
  summa PLS_INTEGER := 0;
BEGIN
  FOR i, j IN PAIRS OF vec WHEN i != 2
  LOOP
     summa := summa + i;
  END LOOP;
END; 