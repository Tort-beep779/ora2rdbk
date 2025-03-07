CREATE PACKAGE PackP_Fetch_Cursor_Into_Var
AS
    PROCEDURE PP_Fetch_Cursor_Into_Var;
END;

CREATE PACKAGE BODY PackP_Fetch_Cursor_Into_Var
AS
    PROCEDURE PP_Fetch_Cursor_Into_Var
    IS
      CURSOR desc_salary IS
        SELECT employee_id, salary
        FROM employees;
      emp_id PLS_INTEGER;
      emp_salary NUMBER(12,3);
    BEGIN
      OPEN desc_salary;
      FETCH desc_salary INTO emp_id, emp_salary;
      CLOSE desc_salary;
    END;
END;