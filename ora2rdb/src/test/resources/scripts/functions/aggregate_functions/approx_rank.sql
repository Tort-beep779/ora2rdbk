SELECT job_id,
      APPROX_RANK(PARTITION BY department_id ORDER BY APPROX_SUM(salary) DESC)
FROM employees
GROUP BY department_id, job_id
HAVING
   APPROX_RANK(
   PARTITION BY department_id
   ORDER BY APPROX_SUM (salary)
   DESC) <= 10;