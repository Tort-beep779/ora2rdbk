CREATE FUNCTION F_Open_Without_Param
RETURN VARCHAR2
IS
  cursor c1 is SELECT num FROM test_table;
BEGIN
  OPEN c1;
  CLOSE c1;
  RETURN '';
END;