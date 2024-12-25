CREATE FUNCTION func
    RETURN VARCHAR2
        AS
    function local_func return number PARALLEL_ENABLE
        AS
        begin
            null;
        end;
BEGIN
    null;
END;