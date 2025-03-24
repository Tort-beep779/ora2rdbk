CREATE FUNCTION F_From_Reverse_Varray
RETURN VARCHAR2(100)
IS
   TYPE varray_t IS VARRAY(4) OF VARCHAR2(15);
   vec varray_t := varray_t('John', 'Mary', 'Alberto', 'Juanita');
   summa VARCHAR2(100) := '';
BEGIN
   FOR i IN REVERSE VALUES OF vec LOOP
      summa := summa || i;
   END LOOP;
END;