CREATE TRIGGER T_Rowcount_In_For_Loop
BEFORE INSERT ON EMPLOYEES
FOR EACH ROW
DECLARE
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
END;