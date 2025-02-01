CREATE EXCEPTION salary_too_high 'salary_too_high exception';
EXECUTE BLOCK
    AS
    /*salary_too_high   EXCEPTION;*/
BEGIN
    IF (current_salary > max_salary) THEN
        EXCEPTION salary_too_high;   -- raise exception
END;