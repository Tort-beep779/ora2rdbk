/*SELECT employee_id, last_name, manager_id
FROM employees
WHERE [-unconvertible CONNECT_BY_ISLEAF] = 1
    [-unconvertible CONNECT BY PRIOR] employee_id = manager_id;*/