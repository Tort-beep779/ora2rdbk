CREATE OR REPLACE TRIGGER T_For_With_Mutable_Index
  AFTER INSERT 
  ON students
  FOR EACH ROW
DECLARE
  TYPE nesttabl_t IS TABLE OF VARCHAR2(15);
   vec nesttabl_t := nesttabl_t('John', 'Mary', 'Alberto', 'Juanita');
   summa VARCHAR2(100) := '';
BEGIN
  FOR i MUTABLE IN VALUES OF vec LOOP
      i := '---';
      summa := summa || i;
  END LOOP;
END; 