В тестах вызывается функция FUNCTION_NAME

    -- Oracle
    CREATE FUNCTION FUNCTION_NAME(out_value OUT VARCHAR2)
    RETURN VARCHAR
    IS
        return_variable VARCHAR(50);
    BEGIN
        out_value := 'out_value';
        return_variable := 'return_value';
    RETURN return_variable;
    END;

В РБД фукнция конвертируется в селективную процедуру из которой можно получить параметры через оператор SELECT 

    -- Ред База Данных
    CREATE PROCEDURE FUNCTION_NAME(out_value  VARCHAR(32765))
    RETURNS ( RET_VAL VARCHAR(32765),OUT_VALUE_OUT VARCHAR(32765))
    SQL SECURITY DEFINER
    AS
        DECLARE return_variable VARCHAR(50);
    BEGIN
        out_value = 'out_value';
        return_variable = 'return_value';
        RET_VAL = return_variable;
        OUT_VALUE_OUT = OUT_VALUE;
    SUSPEND;
    EXIT;
    END;

