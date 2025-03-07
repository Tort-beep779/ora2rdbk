CREATE PACKAGE PackP_Open_Without_Param
AS
    PROCEDURE PP_Open_Without_Param;
END;

CREATE PACKAGE BODY PackP_Open_Without_Param
AS
    PROCEDURE PP_Open_Without_Param
    IS
      cursor c1 is SELECT num FROM test_table;
    BEGIN
      OPEN c1;
      CLOSE c1;
    END;
END;