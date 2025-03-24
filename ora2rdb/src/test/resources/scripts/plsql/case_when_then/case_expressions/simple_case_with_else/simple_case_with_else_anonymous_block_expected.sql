EXECUTE BLOCK
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
END;