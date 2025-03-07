CREATE PROCEDURE P_Fetch_Cursor_Into_Var
SQL SECURITY DEFINER
AS
  DECLARE desc_salary CURSOR FOR (SELECT employee_id, salary FROM employees);
  DECLARE emp_id INTEGER;
  DECLARE emp_salary NUMERIC(12,3);
BEGIN
  OPEN desc_salary;
  FETCH desc_salary INTO :emp_id, :emp_salary;
  CLOSE desc_salary;
END;