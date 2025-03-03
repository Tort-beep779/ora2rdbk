DECLARE
   TYPE nesttabl_t IS TABLE OF VARCHAR2(15);
   vec nesttabl_t := nesttabl_t('John', 'Mary', 'Alberto', 'Juanita');
   summa PLS_INTEGER := 0;
BEGIN
   FOR i, j IN PAIRS OF vec LOOP
      summa := summa + i;
   END LOOP;
END;