В тестах вызывается функция FUNCTION_NAME
 
    -- Oracle
    CREATE FUNCTION FUNCTION_NAME
    RETURN VARCHAR2
    IS
        out_value VARCHAR2(50);
    BEGIN
        out_value := 'return_value';
    RETURN out_value;
    END;

    -- Ред База Данных
    CREATE FUNCTION FUNCTION_NAME
    RETURNS VARCHAR(32765)
    SQL SECURITY DEFINER
    AS
        DECLARE out_value VARCHAR(50);
    BEGIN
        out_value = 'return_value';
    RETURN out_value;
    END;
------------------------------------

Вызов функции без параметров в ORACLE может записываться двумя способами 

    FUNCTION_NAME or FUNCTION_NAME()

В РБД одним 

    FUNCTION_NAME()
    
