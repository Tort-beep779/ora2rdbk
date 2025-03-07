CREATE TRIGGER T_Forall_Found
BEFORE INSERT ON EMPLOYEES
SQL SECURITY DEFINER
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
END;