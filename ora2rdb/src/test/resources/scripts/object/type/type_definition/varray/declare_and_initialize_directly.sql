DECLARE
    TYPE Foursome IS VARRAY(4) OF VARCHAR2(15);

    team Foursome;
BEGIN
    team := Foursome('John', 'Mary', 'Alberto', 'Juanita');
END;