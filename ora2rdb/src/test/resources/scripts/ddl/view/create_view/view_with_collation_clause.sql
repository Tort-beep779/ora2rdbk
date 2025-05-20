CREATE VIEW staff
    DEFAULT COLLATION USINF_NLS_COMP
AS SELECT employee_id, last_name, job_id, manager_id, department_id
   FROM employees;