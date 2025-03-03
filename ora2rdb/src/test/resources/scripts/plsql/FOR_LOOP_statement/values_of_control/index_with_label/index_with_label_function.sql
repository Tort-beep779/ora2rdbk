CREATE FUNCTION F_Index_With_Label
RETURN VARCHAR2(100)
IS
  TYPE nesttabl_t IS TABLE OF VARCHAR2(15);
  vec nesttabl_t := nesttabl_t('John', 'Mary', 'Alberto', 'Juanita');
  summa VARCHAR2(100) := '';
BEGIN
  <<forlabel>>
  FOR i IN VALUES OF vec LOOP
     summa := summa || forlabel.i;
  END LOOP forlabel;
  RETURN summa; 
END; 