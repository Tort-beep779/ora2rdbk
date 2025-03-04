CREATE FUNCTION total_sales (company_id_in IN NUMBER, status_in IN VARCHAR2)
RETURN NUMBER
IS
BEGIN
    RETURN 1;
END;

DECLARE
    return_value NUMBER;
BEGIN
    return_value := total_sales(company_id_in => 1, status_in => 'N');

    return_value := total_sales(status_in => 'N', company_id_in => 1);
END;