CREATE VIEW emp_sal (emp_id, last_name,
                     email UNIQUE RELY DISABLE NOVALIDATE)
AS SELECT employee_id, last_name, email FROM employees;