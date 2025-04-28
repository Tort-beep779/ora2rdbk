SELECT department_id "Department",
       [-unconvertible APPROX_MEDIAN(salary DETERMINISTIC)] "Median Salary"
  FROM employees
  GROUP BY department_id
  ORDER BY department_id;