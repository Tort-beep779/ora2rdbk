SELECT department_id,
       [-unconvertible PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY salary DESC NULLS FIRST)] "Median cont"
  FROM employees
  GROUP BY department_id
  ORDER BY department_id;