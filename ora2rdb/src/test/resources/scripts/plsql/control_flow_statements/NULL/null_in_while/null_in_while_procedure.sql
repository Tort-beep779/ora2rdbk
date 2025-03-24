CREATE PROCEDURE P_Null_In_While
IS
  i PLS_INTEGER := 1;
BEGIN
  NULL;
  WHILE i < 10 
  LOOP
    i := i + 1;
    NULL;
  END LOOP;
END;