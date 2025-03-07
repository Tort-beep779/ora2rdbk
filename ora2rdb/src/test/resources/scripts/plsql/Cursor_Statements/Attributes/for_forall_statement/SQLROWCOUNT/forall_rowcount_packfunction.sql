CREATE PACKAGE PackF_Forall_Rowcount
AS
   FUNCTION PF_Forall_Rowcount 
   RETURN VARCHAR2;
END;

CREATE PACKAGE BODY PackF_Forall_Rowcount
AS
   FUNCTION PF_Forall_Rowcount
   RETURN VARCHAR2
   IS
     TYPE NumList IS VARRAY(3) OF NUMBER;
     depts NumList := NumList(10,20,30);
     tmp PLS_INTEGER;
   BEGIN
     FORALL i IN 1..3  
     UPDATE employees SET SALARY = SALARY * 1.1 WHERE department_id = depts(i);
     tmp := SQL%ROWCOUNT;
     RETURN '';
   END;
END;