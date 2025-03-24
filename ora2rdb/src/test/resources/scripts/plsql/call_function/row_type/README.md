В тесте используются 

    -- Oracle
    CREATE PACKAGE pkg AS
        TYPE my_record IS RECORD (a NUMBER(4) := 10,
                                  b NUMBER(4) := 20
    );
    END pkg;
    
    CREATE OR REPLACE FUNCTION FUNCTION_NAME(in_value IN pkg.my_record)
    RETURN NUMBER
    IS
        first_element NUMBER(4);
    BEGIN
        first_element := in_value.a;
    RETURN first_element;
    END;

    -- РБД 
    CREATE PACKAGE pkg AS BEGIN
        DECLARE TYPE my_record   (a NUMERIC(4) = 10,
                                  b NUMERIC(4) = 20
    );  
    END /*PKG*/;
    
    CREATE FUNCTION FUNCTION_NAME(in_value pkg.my_record)
    RETURNS NUMERIC(34, 8)
    SQL SECURITY DEFINER
    AS
        DECLARE first_element NUMERIC(4);
    BEGIN
        first_element = in_value.a;
    RETURN first_element;
    END;


