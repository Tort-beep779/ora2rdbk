CREATE PACKAGE CALLING_PACKAGE
AS
   FUNCTION CALLING_FUNCTION RETURN NUMBER;
   PROCEDURE CALLING_PROCEDURE;
END CALLING_PACKAGE;

CREATE OR REPLACE PACKAGE BODY CALLING_PACKAGE
AS
   FUNCTION CALLING_FUNCTION
   RETURN NUMBER
   IS
        record_variable pkg.my_record;
        return_value_from_function NUMBER(4);
    BEGIN
        return_value_from_function := FUNCTION_NAME(record_variable); -- call function
    RETURN return_value_from_function;
   END;

   PROCEDURE CALLING_PROCEDURE
    IS
        record_variable pkg.my_record;
        return_value_from_function NUMBER(4);
    BEGIN
        return_value_from_function := FUNCTION_NAME(record_variable); -- call function
    END;

END CALLING_PACKAGE;