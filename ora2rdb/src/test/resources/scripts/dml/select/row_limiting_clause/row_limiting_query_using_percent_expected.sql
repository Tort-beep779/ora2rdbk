/* Use a value instead of a percentage */
SELECT employee_id, last_name, salary
FROM employees
ORDER BY salary
    FETCH FIRST 5 [-unconvertible PERCENT] ROWS ONLY;