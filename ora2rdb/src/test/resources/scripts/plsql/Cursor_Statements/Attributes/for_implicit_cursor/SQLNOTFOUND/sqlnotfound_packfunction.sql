CREATE PACKAGE PackF_Sqlnotfound
AS
   FUNCTION PF_Sqlnotfound 
   RETURN VARCHAR2;
END;

CREATE PACKAGE BODY PackF_Sqlnotfound
AS
   FUNCTION PF_Sqlnotfound
   RETURN VARCHAR2
   IS
     tmp BOOLEAN;
   BEGIN
     tmp := SQL%NOTFOUND;
     UPDATE employees SET SALARY = SALARY * 1.1 WHERE SALARY <= 60000;
     tmp := SQL%NOTFOUND;
     RETURN '';
   END;
END;