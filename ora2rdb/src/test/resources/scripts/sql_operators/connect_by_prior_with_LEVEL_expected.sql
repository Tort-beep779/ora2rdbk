/*SELECT employee_id, last_name, manager_id, [-unconvertible LEVEL]
FROM employees
    [-unconvertible CONNECT BY PRIOR] employee_id = manager_id;*/