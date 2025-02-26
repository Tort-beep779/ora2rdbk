DECLARE
   TYPE nesttabl_t IS TABLE OF VARCHAR2(15);
   vec nesttabl_t := nesttabl_t('John', 'Mary', 'Alberto', 'Juanita');
   summa VARCHAR2(100) := '';
BEGIN
   FOR i IN VALUES OF vec WHEN i != 'Mary'
   LOOP
      summa := summa || i;
   END LOOP;
END;
