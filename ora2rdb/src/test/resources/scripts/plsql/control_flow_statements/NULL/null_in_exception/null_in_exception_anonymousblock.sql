BEGIN
  raise_application_error(-20134, 'Неправильный номер');
  EXCEPTION
    WHEN OTHERS THEN NULL;
END; 