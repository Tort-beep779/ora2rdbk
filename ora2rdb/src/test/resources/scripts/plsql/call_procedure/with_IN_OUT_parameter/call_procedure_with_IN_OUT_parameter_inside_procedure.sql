CREATE PROCEDURE CALLING_PROCEDURE_NAME
    IS
    out_value VARCHAR2(50);
BEGIN
    out_value := 'out_value';
    PROCEDURE_NAME(out_value);
END;