SELECT department_id, job_id,
       [-unconvertible APPROX_COUNT(*)]
FROM   employees
GROUP BY department_id, job_id
HAVING
  [-unconvertible APPROX_RANK (
  PARTITION BY department_id
  ORDER BY APPROX_COUNT(*)
  DESC ) <= 10];