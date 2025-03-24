В тестах используется 

    -- Oracle
    CREATE OR REPLACE PACKAGE pkg AS
    TYPE my_record IS RECORD (a NUMBER(4) := 10,
    b NUMBER(4) := 20
    );
    END pkg;

    CREATE PROCEDURE PROCEDURE_NAME(in_value IN pkg.my_record)
    IS
        first_element NUMBER(4);
    BEGIN
        first_element := in_value.a;
    END;

    -- РБД 
    CREATE PACKAGE pkg AS BEGIN
        DECLARE TYPE my_record   (a NUMERIC(4) = 10,
                                  b NUMERIC(4) = 20
    );  
    END /*PKG*/;
    
    CREATE PROCEDURE PROCEDURE_NAME (in_value pkg.my_record)
    SQL SECURITY DEFINER
    AS
        DECLARE first_element NUMERIC(4);
    BEGIN
        first_element = in_value.a;
    END;