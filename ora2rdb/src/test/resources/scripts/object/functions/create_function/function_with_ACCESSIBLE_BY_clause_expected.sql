/*
 There was ACCESSIBLE BY operator , which is not supported in Red Database
 */
CREATE FUNCTION top_protected_f RETURNS NUMERIC
AS
BEGIN
RETURN 0.5;
END;