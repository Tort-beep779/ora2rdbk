CREATE FUNCTION F_Forall_Notfound
RETURN VARCHAR2
IS
  TYPE NumList IS VARRAY(3) OF NUMBER;
  depts NumList := NumList(10,20,30);
  tmp BOOLEAN;
BEGIN
  FORALL i IN 1..3  
    UPDATE employees SET SALARY = SALARY * 1.1 WHERE department_id = depts(i);
  tmp := SQL%NOTFOUND;
  RETURN '';
END;