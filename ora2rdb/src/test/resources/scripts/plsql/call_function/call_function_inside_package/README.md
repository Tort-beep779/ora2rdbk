В тестах вызывается функция  **FUNCTION_NAME** из пакета  **PACKAGE_NAME**

    -- Oracle 
    CREATE PACKAGE PACKAGE_NAME
    AS
        FUNCTION FUNCTION_NAME(out_value OUT VARCHAR2) RETURN VARCHAR2;
    END PACKAGE_NAME;
    
    CREATE PACKAGE BODY PACKAGE_NAME
    AS
        FUNCTION FUNCTION_NAME (out_value OUT VARCHAR2)
        RETURN VARCHAR2
        IS
        BEGIN
            out_value := 'out_value';
            return 'return_value';
        END;
    END PACKAGE_NAME;

    -- РБД 
    CREATE PACKAGE PACKAGE_NAME
    SQL SECURITY DEFINER
    AS BEGIN
        PROCEDURE FUNCTION_NAME(out_value  VARCHAR(32765))
            RETURNS ( RET_VAL VARCHAR(32765),
            OUT_VALUE_OUT VARCHAR(32765) );  
    END /*PACKAGE_NAME*/;

    CREATE PACKAGE BODY PACKAGE_NAME
    AS BEGIN
        PROCEDURE FUNCTION_NAME (out_value  VARCHAR(32765))
            RETURNS ( RET_VAL VARCHAR(32765),
            OUT_VALUE_OUT VARCHAR(32765))
        AS
        BEGIN
            out_value = 'out_value';
            RET_VAL = 'return_value';
            OUT_VALUE_OUT = OUT_VALUE;
        SUSPEND;
        EXIT;
        END  
    END /*PACKAGE_NAME*/;
