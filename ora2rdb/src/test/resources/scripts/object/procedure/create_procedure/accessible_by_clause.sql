CREATE PROCEDURE combine_and_format_names
accessible by (another_procedure)
IS
BEGIN
    DBMS_OUTPUT.PUT_LINE('procedure triggered');
END;