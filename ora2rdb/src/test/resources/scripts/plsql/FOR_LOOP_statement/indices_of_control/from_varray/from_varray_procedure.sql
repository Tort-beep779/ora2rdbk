CREATE PROCEDURE P_From_Varray
IS
  TYPE varray_t IS VARRAY(4) OF VARCHAR2(15);
  vec varray_t := varray_t('John', 'Mary', 'Alberto', 'Juanita');
  summa PLS_INTEGER := 0;
BEGIN
   FOR i IN INDICES OF vec LOOP
      summa := summa + i;
   END LOOP;
END;