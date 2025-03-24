CREATE PACKAGE PackF_Fetch_Cursor_Into_Var
AS
   FUNCTION PF_Fetch_Cursor_Into_Var 
   RETURN VARCHAR2;
END;

CREATE PACKAGE BODY PackF_Fetch_Cursor_Into_Var
AS
   FUNCTION PF_Fetch_Cursor_Into_Var
   RETURN VARCHAR2
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
     RETURN '';
   END;
END;