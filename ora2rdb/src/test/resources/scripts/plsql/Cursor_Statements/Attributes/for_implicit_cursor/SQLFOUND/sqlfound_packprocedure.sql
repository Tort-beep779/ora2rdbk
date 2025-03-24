CREATE PACKAGE PackP_Sqlfound
AS
    PROCEDURE PP_Sqlfound;
END;

CREATE PACKAGE BODY PackP_Sqlfound
AS
    PROCEDURE PP_Sqlfound
    IS
      tmp BOOLEAN;
    BEGIN
      tmp := SQL%FOUND;
      UPDATE employees SET SALARY = SALARY * 1.1 WHERE SALARY <= 60000;
      tmp := SQL%FOUND;
    END;
END;