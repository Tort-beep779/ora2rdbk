CREATE FUNCTION FUNCTION_NAME
RETURN VARCHAR2
IS
    ret_val_n_f VARCHAR2(20);
    out_val_n_f VARCHAR2(20);

    FUNCTION NESTED_FUNCTION_NAME(out_param OUT VARCHAR2)
    RETURN VARCHAR2
    IS
    BEGIN
        out_param := 'out_param';
        RETURN 'return_param';
    END;
BEGIN
    ret_val_n_f := FUNCTION_NAME.NESTED_FUNCTION_NAME(out_val_n_f);
    return ret_val_n_f || out_val_n_f;
END;