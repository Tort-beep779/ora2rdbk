DECLARE
  i PLS_INTEGER;
BEGIN
  GOTO first_label;
  i := 10; 
  <<first_label>>
  i := 1;
END; 