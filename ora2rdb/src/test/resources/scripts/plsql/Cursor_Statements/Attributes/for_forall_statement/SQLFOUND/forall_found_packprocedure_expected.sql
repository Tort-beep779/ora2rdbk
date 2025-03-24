CREATE PACKAGE PackP_Forall_Found
SQL SECURITY DEFINER
AS BEGIN
    PROCEDURE PP_Forall_Found;
END;

CREATE PACKAGE BODY PackP_Forall_Found
AS
BEGIN
    PROCEDURE PP_Forall_Found
    AS
      /*
        TYPE NumList IS VARRAY(3) OF NUMBER;
        depts NumList := NumList(10,20,40);
        DECLARE tmp BOOLEAN; 
      */
      BEGIN
      /*
        FORALL i IN 1..3  
          UPDATE employees SET SALARY = SALARY * 1.1 WHERE department_id = depts(i);
        tmp := SQL%FOUND;
      */
    END
END;