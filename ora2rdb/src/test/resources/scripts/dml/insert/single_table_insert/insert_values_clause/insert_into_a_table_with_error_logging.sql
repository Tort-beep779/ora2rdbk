INSERT INTO raises
SELECT employee_id, salary*1.1 FROM employees
WHERE commission_pct > 1
    LOG ERRORS INTO errlog ('my_bad') REJECT LIMIT 10;