DECLARE
    salary_too_high   EXCEPTION;
BEGIN
    IF current_salary > max_salary THEN
      RAISE salary_too_high;   -- raise exception
    END IF;
    EXCEPTION
        WHEN salary_too_high THEN  -- start handling exception
          RAISE;  -- reraise current exception (exception name is optional)
END;
