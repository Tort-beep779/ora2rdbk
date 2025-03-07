CREATE PROCEDURE P_Rowcount_In_For_Loop
SQL SECURITY DEFINER
AS
  DECLARE c1 CURSOR FOR (SELECT last_name, salary FROM employees WHERE salary > 10000 ORDER BY last_name);

  DECLARE rc INTEGER;
  DECLARE c1_record TYPE OF TABLE c1;
  DECLARE c1_counter INT = 0;
BEGIN
  OPEN c1;
  FETCH c1 INTO :c1_record;
  c1_counter = c1_counter + ROW_COUNT;
  WHILE ( ROW_COUNT != 0 ) DO 
  BEGIN
    rc = c1_counter;
    FETCH c1 INTO :c1_record;
    c1_counter = c1_counter + ROW_COUNT;  
  END   
  CLOSE c1;
END;