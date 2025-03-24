CREATE PACKAGE PackP_Sqlrowcount
AS
    PROCEDURE PP_Sqlrowcount;
END;

CREATE PACKAGE BODY PackP_Sqlrowcount
AS
    PROCEDURE PP_Sqlrowcount
    IS
      tmp PLS_INTEGER;
    BEGIN
      tmp := SQL%ROWCOUNT;
      UPDATE employees SET SALARY = SALARY * 1.1 WHERE SALARY <= 60000;
      tmp := SQL%ROWCOUNT;
    END;
END;