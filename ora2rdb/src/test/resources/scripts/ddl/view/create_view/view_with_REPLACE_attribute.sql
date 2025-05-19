CREATE OR REPLACE VIEW staff AS
SELECT employee_id, last_name, job_id, manager_id, department_id
FROM   employees;