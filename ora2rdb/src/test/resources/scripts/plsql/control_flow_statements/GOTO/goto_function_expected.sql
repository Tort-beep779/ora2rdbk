CREATE FUNCTION F_Goto
RETURNS VARCHAR(32765)
SQL SECURITY DEFINER
AS
/*
  i PLS_INTEGER;
*/
BEGIN
/*
  GOTO first_label;
  i := 10; 
  <<first_label>>
  i := 1;
*/
  RETURN '';
END;