CREATE PACKAGE PackF_Fetch_Bulk_Collect
AS
   FUNCTION PF_Fetch_Bulk_Collect 
   RETURN VARCHAR2;
END;

CREATE PACKAGE BODY PackF_Fetch_Bulk_Collect
AS
   FUNCTION PF_Fetch_Bulk_Collect
   RETURN VARCHAR2
   IS
     TYPE NameList IS TABLE OF employees.last_name%TYPE;
     TYPE SalList IS TABLE OF employees.salary%TYPE;

     CURSOR c1 IS
       SELECT last_name, salary
       FROM employees
       WHERE salary > 10000
       ORDER BY last_name;

     names  NameList;
     sals   SalList;
   BEGIN
     OPEN c1;
     FETCH c1 BULK COLLECT INTO names, sals;
     CLOSE c1;
     RETURN '';
   END;
END;