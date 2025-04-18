 SELECT manager_id, last_name, hire_date, salary,
       AVG(salary) OVER (PARTITION BY manager_id ORDER BY hire_date) AS c_mavg
  FROM employees
  ORDER BY manager_id, hire_date, salary;