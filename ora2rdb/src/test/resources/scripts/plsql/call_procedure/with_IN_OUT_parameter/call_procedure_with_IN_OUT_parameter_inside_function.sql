CREATE FUNCTION CALLING_FUNCTION_NAME
RETURN VARCHAR2
    IS
    out_value VARCHAR2(50);
BEGIN
    out_value := 'out_value';
    PROCEDURE_NAME(out_value);
END;