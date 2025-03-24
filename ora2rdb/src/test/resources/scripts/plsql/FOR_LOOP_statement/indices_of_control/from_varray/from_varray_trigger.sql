CREATE OR REPLACE TRIGGER T_From_Varray
  AFTER INSERT 
  ON students
  FOR EACH ROW
DECLARE
  TYPE varray_t IS VARRAY(4) OF VARCHAR2(15);
   vec varray_t := varray_t('John', 'Mary', 'Alberto', 'Juanita');
   summa PLS_INTEGER := 0;
BEGIN
   FOR i IN INDICES OF vec LOOP
      summa := summa + i;
   END LOOP;
END;