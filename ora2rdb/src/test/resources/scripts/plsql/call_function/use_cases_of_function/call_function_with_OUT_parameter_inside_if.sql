CREATE FUNCTION CALLING_F
RETURN VARCHAR2
IS
    out_value_from_function VARCHAR2(50);
    return_value_from_function VARCHAR(50);
BEGIN
    if (FUNCTION_NAME(out_value_from_function, 'in_value') = 'in_value') then   -- inside IF-ELSE
        RETURN out_value_from_function;
    end if;
    RETURN 'empty';
END;