CREATE PACKAGE CALLING_PACKAGE
AS
   FUNCTION CALLING_FUNCTION RETURN VARCHAR2;
   PROCEDURE CALLING_PROCEDURE;
END CALLING_PACKAGE;

CREATE PACKAGE BODY CALLING_PACKAGE
AS
   FUNCTION CALLING_FUNCTION
   RETURN VARCHAR2
   IS
        value_in_function VARCHAR2(50);
        value_from_function VARCHAR2(50);
    BEGIN
        value_in_function := 'value';
        value_from_function := FUNCTION_NAME(value_in_function); -- call function
    RETURN value_from_function;
   END;

   PROCEDURE CALLING_PROCEDURE
    IS
        value_in_function VARCHAR2(50);
        value_from_function VARCHAR2(50);
    BEGIN
        value_in_function := 'value';
        value_from_function := FUNCTION_NAME(value_in_function); -- call function
    END;
END CALLING_PACKAGE;