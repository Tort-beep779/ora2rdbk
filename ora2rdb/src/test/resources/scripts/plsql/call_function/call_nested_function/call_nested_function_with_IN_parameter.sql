CREATE FUNCTION FUNCTION_NAME
RETURN VARCHAR2
IS
    ret_val_n_f VARCHAR2(20);
    in_val_n_f VARCHAR2(20);

    FUNCTION NESTED_FUNCTION_NAME(in_param IN VARCHAR2)
    RETURN VARCHAR2
    IS
    BEGIN
        RETURN in_param;
    END;
BEGIN
    ret_val_n_f := FUNCTION_NAME.NESTED_FUNCTION_NAME(in_val_n_f);
    return ret_val_n_f || in_val_n_f;
END;