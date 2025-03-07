CREATE TRIGGER T_Fetch_Cursor_Into_Record
BEFORE INSERT ON EMPLOYEES
FOR EACH ROW
DECLARE
  CURSOR desc_salary IS
    SELECT employee_id, salary
    FROM employees;
  emp_rec desc_salary%ROWTYPE;
BEGIN
  OPEN desc_salary;
  FETCH desc_salary INTO emp_rec;
  CLOSE desc_salary;
END;