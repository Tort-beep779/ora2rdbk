CREATE FUNCTION func
    RETURN VARCHAR2
AS
    function local_func return number DETERMINISTIC;
    function local_func return number DETERMINISTIC
        AS
        begin
            null;
        end;
BEGIN
    null;
END;
