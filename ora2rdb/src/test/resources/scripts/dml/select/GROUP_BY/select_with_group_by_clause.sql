SELECT dept_no, COUNT(*) as employee_count
FROM employee
GROUP BY dept_no;