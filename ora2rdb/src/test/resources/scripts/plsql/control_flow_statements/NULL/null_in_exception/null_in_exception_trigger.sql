CREATE TRIGGER T_Null_In_Exception
BEFORE INSERT ON EMPLOYEES
FOR EACH ROW
BEGIN
  raise_application_error(-20134, 'Неправильный номер');
  EXCEPTION
    WHEN OTHERS THEN NULL;
END;