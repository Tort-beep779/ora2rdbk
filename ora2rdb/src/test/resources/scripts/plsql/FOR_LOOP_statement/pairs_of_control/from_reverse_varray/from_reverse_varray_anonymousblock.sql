DECLARE
   TYPE varray_t IS VARRAY(4) OF VARCHAR2(15);
   vec varray_t := varray_t('John', 'Mary', 'Alberto', 'Juanita');
   summa PLS_INTEGER := 0;
BEGIN
   FOR i, j IN REVERSE PAIRS OF vec LOOP
      summa := summa + i;
   END LOOP;
END;