CREATE PROCEDURE P_Open_Without_Param
IS
  cursor c1 is SELECT num FROM test_table;
BEGIN
  OPEN c1;
  CLOSE c1;
END;