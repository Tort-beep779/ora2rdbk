CREATE FUNCTION F_Goto
RETURN VARCHAR2
IS
  i PLS_INTEGER;
BEGIN
  GOTO first_label;
  i := 10; 
  <<first_label>>
  i := 1;
  RETURN '';
END;