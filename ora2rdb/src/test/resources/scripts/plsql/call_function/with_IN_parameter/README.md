В тестах вызывается функция FUNCTION_NAME

    -- Oracle
    CREATE FUNCTION FUNCTION_NAME(out_value IN VARCHAR2)
    RETURN VARCHAR2
    IS
    BEGIN
    RETURN out_value;
    END;

    -- Ред База Данных
    CREATE FUNCTION FUNCTION_NAME(out_value VARCHAR(32765))
    RETURNS VARCHAR(32765)
    SQL SECURITY DEFINER
    AS
    BEGIN
    RETURN out_value;
    END;