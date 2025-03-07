CREATE TRIGGER T_Fetch_Bulk_Collect
BEFORE INSERT ON EMPLOYEES
FOR EACH ROW
DECLARE
  TYPE NameList IS TABLE OF employees.last_name%TYPE;
  TYPE SalList IS TABLE OF employees.salary%TYPE;

  CURSOR c1 IS
    SELECT last_name, salary
    FROM employees
    WHERE salary > 10000
    ORDER BY last_name;

  names  NameList;
  sals   SalList;
BEGIN
  OPEN c1;
  FETCH c1 BULK COLLECT INTO names, sals;
  CLOSE c1;
END;