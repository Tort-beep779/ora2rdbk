SELECT department_id,
       MAX(salary) [-unconvertible KEEP (DENSE_RANK LAST ORDER BY commission_pct)] "Best"
  FROM employees
  GROUP BY department_id
  ORDER BY department_id;