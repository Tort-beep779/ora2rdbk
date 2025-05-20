CREATE VIEW staff SHARING=NONE
    AS SELECT employee_id, last_name, job_id, manager_id, department_id
    FROM   employees;