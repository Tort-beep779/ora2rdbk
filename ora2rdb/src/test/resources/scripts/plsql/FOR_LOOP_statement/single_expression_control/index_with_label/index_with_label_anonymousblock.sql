DECLARE
  summa PLS_INTEGER := 0;
BEGIN
  <<forlabel>>
  FOR i IN 1 LOOP
      summa := summa + forlabel.i;
  END LOOP forlabel;
END; 