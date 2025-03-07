CREATE PACKAGE PackP_Forall_Notfound
SQL SECURITY DEFINER
AS BEGIN
    PROCEDURE PP_Forall_Notfound;
END;

CREATE PACKAGE BODY PackP_Forall_Notfound
AS
BEGIN
    PROCEDURE PP_Forall_Notfound
    AS
      /*
        TYPE NumList IS VARRAY(3) OF NUMBER;
        depts NumList := NumList(10,20,30);
        DECLARE tmp BOOLEAN; 
      */
      BEGIN
      /*
        FORALL i IN 1..3  
          UPDATE employees SET SALARY = SALARY * 1.1 WHERE department_id = depts(i);
        tmp := SQL%NOTFOUND;
      */
    END
END;