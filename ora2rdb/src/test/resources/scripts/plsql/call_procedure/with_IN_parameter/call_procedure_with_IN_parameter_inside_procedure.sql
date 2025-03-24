CREATE PROCEDURE CALLING_PROCEDURE_NAME
    IS
    in_value VARCHAR2(50);
BEGIN
    in_value := 'in_value';
    PROCEDURE_NAME(in_value);
END;