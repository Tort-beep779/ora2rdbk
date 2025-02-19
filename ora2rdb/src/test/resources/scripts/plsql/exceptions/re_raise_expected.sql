CREATE EXCEPTION salary_too_high 'salary_too_high exception';
EXECUTE BLOCK
    AS
    /*salary_too_high   EXCEPTION;*/
BEGIN
    IF (current_salary > max_salary) THEN
        EXCEPTION salary_too_high;   -- raise exception

    /*EXCEPTION*/
        WHEN EXCEPTION SALARY_TOO_HIGH DO
            BEGIN
	          EXCEPTION salary_too_high; -- reraise current exception
            END
END;