CREATE PACKAGE PackP_Rowcount_In_For_Loop
AS
    PROCEDURE PP_Rowcount_In_For_Loop;
END;

CREATE PACKAGE BODY PackP_Rowcount_In_For_Loop
AS
  PROCEDURE PP_Rowcount_In_For_Loop
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
  END;
END;