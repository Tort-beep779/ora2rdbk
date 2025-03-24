CREATE FUNCTION F_Rowcount_In_For_Loop
RETURN VARCHAR2
IS
  CURSOR c1 IS
    SELECT last_name, salary
    FROM employees
    WHERE salary > 10000
    ORDER BY last_name;

  rc PLS_INTEGER;
BEGIN
  FOR i IN c1
  LOOP
    rc := c1%ROWCOUNT;
  END LOOP;
  RETURN '';
END;