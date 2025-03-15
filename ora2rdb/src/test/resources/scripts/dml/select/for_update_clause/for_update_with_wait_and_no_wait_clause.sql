SELECT employee_id, last_name from employees
    FOR UPDATE nowait;

SELECT employee_id, last_name from employees
    FOR UPDATE wait 3;