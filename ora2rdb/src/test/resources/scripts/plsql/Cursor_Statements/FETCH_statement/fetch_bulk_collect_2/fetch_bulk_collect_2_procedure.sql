CREATE PROCEDURE P_Fetch_Bulk_Collect_2
IS
  CURSOR c1 IS
    SELECT last_name, salary
    FROM employees
    WHERE salary > 10000
    ORDER BY last_name;

  TYPE RecList IS TABLE OF c1%ROWTYPE;
  recs RecList;
BEGIN
  OPEN c1;
  FETCH c1 BULK COLLECT INTO recs;
  CLOSE c1;
END;