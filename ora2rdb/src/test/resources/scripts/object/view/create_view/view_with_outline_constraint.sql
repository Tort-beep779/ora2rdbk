CREATE VIEW emp_sal (emp_id, last_name,
                     CONSTRAINT id_pk PRIMARY KEY (emp_id) RELY DISABLE NOVALIDATE)
AS SELECT employee_id, last_name FROM employees;