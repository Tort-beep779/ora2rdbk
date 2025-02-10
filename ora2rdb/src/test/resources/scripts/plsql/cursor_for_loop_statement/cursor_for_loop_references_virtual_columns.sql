BEGIN
FOR item IN (
    SELECT first_name || ' ' || last_name AS full_name,
    salary * 10                    AS dream_salary
    FROM employees
  ) LOOP
        item.full_name = 'UNKNOWN';
        item.dream_salary = 0;
    END LOOP;
END;