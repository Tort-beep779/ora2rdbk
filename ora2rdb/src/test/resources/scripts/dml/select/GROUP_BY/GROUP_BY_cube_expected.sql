SELECT department_id, COUNT(*) as employee_count
FROM employees
GROUP BY [-unconvertible CUBE (department_id, job_id)];