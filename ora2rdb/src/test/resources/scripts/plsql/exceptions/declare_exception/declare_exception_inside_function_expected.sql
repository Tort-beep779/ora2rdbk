CREATE EXCEPTION invalid_company_id 'invalid_company_id exception';

CREATE FUNCTION test_f
RETURNS BOOLEAN
    SQL SECURITY DEFINER
AS
    /*invalid_company_id EXCEPTION;*/
BEGIN
    NULL;
RETURN TRUE;
END;