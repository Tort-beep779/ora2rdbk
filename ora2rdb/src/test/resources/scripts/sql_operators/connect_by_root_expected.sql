/*SELECT employee_id, [-unconvertible CONNECT_BY_ROOT] last_name, manager_id
FROM employees
    [-unconvertible CONNECT BY PRIOR] employee_id = manager_id;*/