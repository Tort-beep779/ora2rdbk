CREATE FUNCTION F_multiple
RETURN PLS_INTEGER
IS
   TYPE varray_t1 IS VARRAY(5) OF VARCHAR2(15);
   vec1 varray_t1 := varray_t1('Olivia', 'William', 'Emma', 'Henry', 'Grace');
   TYPE nesttabl_t2 IS TABLE OF VARCHAR2(15);
   vec2 nesttabl_t2 := nesttabl_t2('John', 'Mary', 'Alberto', 'Juanita');
   summa PLS_INTEGER := 0;
BEGIN
   FOR i IN INDICES OF vec1, INDICES OF vec2, 100
   LOOP
     summa := summa + i;
   END LOOP;
  RETURN 0;
END; 