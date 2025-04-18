/*SELECT employee_id, last_name, manager_id
FROM employees
    [-unconvertible CONNECT BY PRIOR] employee_id = manager_id;*/