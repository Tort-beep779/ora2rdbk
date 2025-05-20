CREATE TRIGGER T_Goto
BEFORE INSERT ON EMPLOYEES
SQL SECURITY DEFINER
AS
/*
  i PLS_INTEGER;
*/
BEGIN
/*
  [-unconvertible GOTO] first_label;
  i := 10; 
  <<first_label>>
  i := 1;
*/
END;