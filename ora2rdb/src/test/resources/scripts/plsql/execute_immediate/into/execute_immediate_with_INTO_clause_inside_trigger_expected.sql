CREATE OR ALTER TRIGGER call_tr
AFTER INSERT
ON country
SQL SECURITY DEFINER
AS
    DECLARE emp_name VARCHAR(50);
    DECLARE emp_salary NUMERIC(34, 8);
BEGIN
    EXECUTE STATEMENT ('SELECT first_name, salary FROM employees WHERE employee_id = 142')
    INTO :emp_name, :emp_salary;
END;