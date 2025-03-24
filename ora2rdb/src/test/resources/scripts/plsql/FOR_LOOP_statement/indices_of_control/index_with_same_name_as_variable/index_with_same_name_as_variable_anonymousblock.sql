DECLARE
  TYPE varray_t IS VARRAY(4) OF VARCHAR2(15);
  vec varray_t := varray_t('John', 'Mary', 'Alberto', 'Juanita');
  summa PLS_INTEGER := 0;
  i PLS_INTEGER;
BEGIN
  FOR i IN INDICES OF vec LOOP
      summa := summa + i;
  END LOOP;
  i := 100;
  summa := summa + i;
END; 