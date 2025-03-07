CREATE FUNCTION F_Fetch_Bulk_Collect_Limit
RETURN VARCHAR2
IS
  TYPE numtab IS TABLE OF employees.salary%TYPE INDEX BY PLS_INTEGER;

  CURSOR c1 IS
    SELECT salary
    FROM employees
    WHERE salary > 10000
    ORDER BY last_name;

  sals numtab;
BEGIN
  OPEN c1;
  FETCH c1 BULK COLLECT INTO sals LIMIT 4;
  CLOSE c1;
  RETURN '';
END;