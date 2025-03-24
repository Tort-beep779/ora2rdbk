CREATE FUNCTION F_Null_In_Exception
RETURN VARCHAR2
IS
BEGIN
  raise_application_error(-20134, 'Неправильный номер');
  EXCEPTION
    WHEN OTHERS THEN NULL;
  RETURN '';
END;