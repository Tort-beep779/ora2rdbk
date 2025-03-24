CREATE OR ALTER PACKAGE package_name
SQL SECURITY DEFINER
AS BEGIN
    FUNCTION simple_case_function RETURNS VARCHAR(32765);
END /*PACKAGE_NAME*/;

RECREATE PACKAGE BODY package_name
AS BEGIN
    FUNCTION simple_case_function
    RETURNS VARCHAR(32765)
    AS
        DECLARE grade CHAR(1);
        DECLARE appraisal VARCHAR(20);
    BEGIN
        appraisal =
            CASE :grade
                WHEN NULL THEN 'No grade assigned'
                WHEN 'A' THEN 'Excellent'
                ELSE 'No such grade'
            END;
        RETURN appraisal;
    END
END /*PACKAGE_NAME*/;