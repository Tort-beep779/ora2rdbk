/*
 There was ACCESSIBLE BY operator , which is not supported in Red Database
 */
CREATE FUNCTION top_protected_f RETURNS NUMERIC
    SQL SECURITY DEFINER
AS
BEGIN

END;