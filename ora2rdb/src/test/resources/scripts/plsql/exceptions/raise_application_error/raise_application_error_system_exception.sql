DECLARE
    v_salary NUMBER := -5000;
BEGIN
    IF v_salary < 0 THEN
        RAISE_APPLICATION_ERROR(-20001, 'Salary cannot be negative.');
    END IF;
END;