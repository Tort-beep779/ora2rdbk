SELECT department_id,
       PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY salary DESC) "Median cont"
  FROM employees
  GROUP BY department_id
  ORDER BY department_id;