CREATE PACKAGE PackP_Sqlnotfound
AS
    PROCEDURE PP_Sqlnotfound;
END;

CREATE PACKAGE BODY PackP_Sqlnotfound
AS
    PROCEDURE PP_Sqlnotfound
    IS
      tmp BOOLEAN;
    BEGIN
      tmp := SQL%NOTFOUND;
      UPDATE employees SET SALARY = SALARY * 1.1 WHERE SALARY <= 60000;
      tmp := SQL%NOTFOUND;
    END;
END;