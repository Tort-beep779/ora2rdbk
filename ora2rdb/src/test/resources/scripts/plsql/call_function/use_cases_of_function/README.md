Различные случаи использования функции  (внутри select , внутри IF)

### [call_function_with_OUT_parameter_inside_if.sql](call_function_with_OUT_parameter_inside_if.sql)

В тесте вызывается фукнция

    -- Oracle
    CREATE OR REPLACE FUNCTION FUNCTION_NAME(out_value OUT VARCHAR2, in_value IN VARCHAR2)
    RETURN VARCHAR
    IS
        return_variable VARCHAR(50);
    BEGIN
        out_value := 'out_value';
        return_variable := in_value;
    RETURN return_variable;
    END;

    -- РБД 
    CREATE OR ALTER PROCEDURE FUNCTION_NAME(out_value  VARCHAR(32765), in_value  VARCHAR(32765))
    RETURNS ( RET_VAL VARCHAR(32765),
    OUT_VALUE_OUT VARCHAR(32765))
    AS
        DECLARE return_variable VARCHAR(50);
    BEGIN
        out_value = 'out_value';
        return_variable = :in_value;
    RET_VAL = return_variable;
    OUT_VALUE_OUT = OUT_VALUE;
    SUSPEND;
    EXIT;
    END;

-------------------------------------------

### [call_function_with_IN_parameter_inside_if.sql](call_function_with_IN_parameter_inside_if.sql)

В тесте вызывается функция 
    
    -- Oracle 
    CREATE OR REPLACE FUNCTION FUNCTION_NAME_WITH_IN_PARAMETER(in_value IN VARCHAR2)
    RETURN VARCHAR
    IS
        return_variable VARCHAR(50);
    BEGIN
        return_variable := in_value;
    RETURN return_variable;
    END;

    -- РБД 
    CREATE OR ALTER FUNCTION FUNCTION_NAME_WITH_IN_PARAMETER(in_value  VARCHAR(32765))
    RETURNS VARCHAR(32765)
    AS
         DECLARE return_variable VARCHAR(50);
    BEGIN
        return_variable = :in_value;
    RETURN return_variable;
    END;

-------------------------------------------

### [call_function_with_IN_parameter_using_select.sql](call_function_with_IN_parameter_using_select.sql)

В тесте вызывается та же функция как и здесь 
[call_function_with_IN_parameter_inside_if.sql](call_function_with_IN_parameter_inside_if.sql)

Нельзя вызвать функцию используя SELECT если она содержит OUT параметр (только IN)