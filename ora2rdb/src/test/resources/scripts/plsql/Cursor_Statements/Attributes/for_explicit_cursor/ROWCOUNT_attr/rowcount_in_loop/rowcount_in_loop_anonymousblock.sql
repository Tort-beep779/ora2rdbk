DECLARE
  CURSOR c1 IS
    SELECT last_name, salary
    FROM employees
    WHERE salary > 10000
    ORDER BY last_name;

  recs c1%ROWTYPE;
  rc PLS_INTEGER;
  counter PLS_INTEGER := 0;
BEGIN
  OPEN c1;
  LOOP
    FETCH c1 INTO recs;
    counter := counter +1; 
    EXIT WHEN counter > 10;
  END LOOP;
  rc := c1%ROWCOUNT;
  CLOSE c1;
END;