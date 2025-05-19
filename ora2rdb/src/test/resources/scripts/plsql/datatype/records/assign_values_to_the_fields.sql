DECLARE
    TYPE employee_record IS RECORD (
        emp_id NUMBER,
        emp_name VARCHAR2(50),
        emp_salary NUMBER
    );

    emp employee_record;
BEGIN
    emp.emp_id := 1001;
    emp.emp_name := 'John Doe';
    emp.emp_salary := 50000;
END;