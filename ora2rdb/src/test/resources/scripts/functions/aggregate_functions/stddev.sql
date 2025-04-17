SELECT STDDEV(salary) "Deviation"
   FROM employees;

SELECT STDDEV(ALL salary) "Deviation"
   FROM employees;

SELECT STDDEV(DISTINCT salary) "Deviation"
   FROM employees;