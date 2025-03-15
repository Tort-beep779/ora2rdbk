SELECT dept_no, AVG(salary) as avg_salary
FROM employee
GROUP BY dept_no
HAVING AVG(salary) > 5000;