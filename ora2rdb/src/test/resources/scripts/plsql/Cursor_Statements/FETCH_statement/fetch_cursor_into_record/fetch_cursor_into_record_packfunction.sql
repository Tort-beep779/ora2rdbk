CREATE PACKAGE PackF_Fetch_Cursor_Into_Record
AS
   FUNCTION PF_Fetch_Cursor_Into_Record 
   RETURN VARCHAR2;
END;

CREATE PACKAGE BODY PackF_Fetch_Cursor_Into_Record
AS
   FUNCTION PF_Fetch_Cursor_Into_Record
   RETURN VARCHAR2
   IS
     CURSOR desc_salary IS
        SELECT employee_id, salary
        FROM employees;
      emp_rec desc_salary%ROWTYPE;
    BEGIN
      OPEN desc_salary;
      FETCH desc_salary INTO emp_rec;
      CLOSE desc_salary;
     RETURN '';
   END;
END;