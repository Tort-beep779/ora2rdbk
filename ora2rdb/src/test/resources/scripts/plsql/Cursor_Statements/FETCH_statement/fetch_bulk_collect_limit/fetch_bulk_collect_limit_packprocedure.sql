CREATE PACKAGE PackP_Fetch_Bulk_Collect_Limit
AS
    PROCEDURE PP_Fetch_Bulk_Collect_Limit;
END;

CREATE PACKAGE BODY PackP_Fetch_Bulk_Collect_Limit
AS
    PROCEDURE PP_Fetch_Bulk_Collect_Limit
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
    END;
END;