DECLARE
  TYPE nesttabl_t IS TABLE OF VARCHAR2(15);
   vec nesttabl_t := nesttabl_t('John', 'Mary', 'Alberto', 'Juanita');
   summa PLS_INTEGER := 0;
BEGIN
  <<forlabel>>
  FOR i IN INDICES OF vec LOOP
      summa := summa + forlabel.i;
  END LOOP forlabel;
END; 