CREATE PACKAGE PackP_Open_Without_Param
SQL SECURITY DEFINER
AS BEGIN
    PROCEDURE PP_Open_Without_Param;
END;

CREATE PACKAGE BODY PackP_Open_Without_Param
AS
BEGIN
    PROCEDURE PP_Open_Without_Param
    AS
      DECLARE c1 CURSOR FOR (SELECT num FROM test_table);
    BEGIN
      OPEN c1;
      CLOSE c1;
    END
END;