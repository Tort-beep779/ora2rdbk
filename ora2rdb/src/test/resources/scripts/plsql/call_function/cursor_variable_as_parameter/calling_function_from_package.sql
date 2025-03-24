CREATE PACKAGE CALLING_PACKAGE
AS
   FUNCTION CALLING_FUNCTION RETURN NUMBER;
   PROCEDURE CALLING_PROCEDURE;
END CALLING_PACKAGE;

CREATE PACKAGE BODY CALLING_PACKAGE
AS
   FUNCTION CALLING_FUNCTION
   RETURN NUMBER
   IS
        cursor_variable pkg.cursor_type;
        return_value_from_function NUMBER;
    BEGIN
        return_value_from_function := FUNCTION_NAME(cursor_variable); -- call function
    RETURN 1;
   END;

   PROCEDURE CALLING_PROCEDURE
    IS
         cursor_variable pkg.cursor_type;
        return_value_from_function NUMBER;
    BEGIN
         return_value_from_function := FUNCTION_NAME(cursor_variable); -- call function
    END;

END CALLING_PACKAGE;