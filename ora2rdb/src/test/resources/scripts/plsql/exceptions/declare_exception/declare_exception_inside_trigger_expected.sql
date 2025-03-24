CREATE EXCEPTION invalid_company_id 'invalid_company_id exception';

CREATE TRIGGER T_Grade_meaning1
    AFTER INSERT
    ON EMPLOYEES
    SQL SECURITY DEFINER
AS
    /*invalid_company_id EXCEPTION;*/
BEGIN

END;