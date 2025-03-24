CREATE PACKAGE PackF_Forall_Found
AS
   FUNCTION PF_Forall_Found 
   RETURN VARCHAR2;
END;

CREATE PACKAGE BODY PackF_Forall_Found
AS
   FUNCTION PF_Forall_Found
   RETURN VARCHAR2
   IS
     TYPE NumList IS VARRAY(3) OF NUMBER;
     depts NumList := NumList(10,20,40);
     tmp BOOLEAN;
   BEGIN
     FORALL i IN 1..3  
     UPDATE employees SET SALARY = SALARY * 1.1 WHERE department_id = depts(i);
     tmp := SQL%FOUND;
     RETURN '';
   END;
END;