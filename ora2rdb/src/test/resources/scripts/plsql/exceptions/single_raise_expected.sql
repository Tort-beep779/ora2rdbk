CREATE EXCEPTION salary_too_high 'salary_too_high exception';
EXECUTE BLOCK
    AS
    /*salary_too_high   EXCEPTION;*/

BEGIN
    IF (current_salary > max_salary) THEN
        EXCEPTION salary_too_high;   -- raise exception

    /*EXCEPTION*/
        WHEN EXCEPTION SALARY_TOO_HIGH DO  -- start handling exception
            BEGIN
	          EXCEPTION salary_too_high; -- reraise current exception (exception name is optional)
            END
END;