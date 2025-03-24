CREATE PROCEDURE P_multiple
IS
   TYPE varray_t1 IS VARRAY(5) OF VARCHAR2(15);
   vec1 varray_t1 := varray_t1('Olivia', 'William', 'Emma', 'Henry', 'Grace');
   TYPE nesttabl_t2 IS TABLE OF VARCHAR2(15);
   vec2 nesttabl_t2 := nesttabl_t2('John', 'Mary', 'Alberto', 'Juanita');
   summa VARCHAR2(150) := '';
BEGIN
   FOR i IN VALUES OF vec1, VALUES OF vec2, 'Lily'
   LOOP
     summa := summa || i;
   END LOOP;
END; 