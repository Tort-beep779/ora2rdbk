DECLARE
    emp_name VARCHAR2(50);
    emp_salary NUMBER;
BEGIN
    EXECUTE IMMEDIATE 'SELECT first_name, salary FROM employees WHERE employee_id = 142'
    INTO emp_name, emp_salary;
END;