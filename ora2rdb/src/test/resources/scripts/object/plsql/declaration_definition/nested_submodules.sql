CREATE PROCEDURE pr AS
    PROCEDURE nested_pr IS
        PROCEDURE nested_pr_2 IS
        BEGIN
            null;
        END;
    BEGIN
        null;
    END;
BEGIN
    null;
END;