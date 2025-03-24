DECLARE
    salary_too_high   EXCEPTION;
BEGIN
    IF current_salary > max_salary THEN
        RAISE salary_too_high;   -- raise exception
    END IF;
END;