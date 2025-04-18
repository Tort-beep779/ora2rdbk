DECLARE
    TYPE Foursome IS VARRAY(4) OF VARCHAR2(15);

    team Foursome := Foursome('John', 'Mary', 'Alberto', 'Juanita');
BEGIN
    NULL;
END;