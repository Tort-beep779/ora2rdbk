DECLARE
  cursor c1 is SELECT num FROM test_table;
BEGIN
  OPEN c1;
  CLOSE c1;
END;
