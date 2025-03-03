CREATE PROCEDURE P_For_With_While_and_When
IS
  TYPE varray_t IS VARRAY(4) OF VARCHAR2(15);
  vec varray_t := varray_t('John', 'Mary', 'Alberto', 'Juanita');
  summa INTEGER := 0;
BEGIN
  FOR i IN INDICES OF vec WHILE i != 4 WHEN i != 2
  LOOP
     summa := summa + i;
  END LOOP;
END; 