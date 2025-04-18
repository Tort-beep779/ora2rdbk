SELECT department_id,
       MIN(salary) KEEP (DENSE_RANK FIRST ORDER BY commission_pct) "Worst"
  FROM employees
  GROUP BY department_id
  ORDER BY department_id;