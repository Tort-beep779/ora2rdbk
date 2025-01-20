CREATE GLOBAL TEMPORARY TABLE TEAM (
    VAL VARCHAR(15)
);

EXECUTE BLOCK
    AS
    /*TYPE Foursome IS VARRAY(4) OF VARCHAR(15);*/

    /*team Foursome := Foursome('John', 'Mary', 'Alberto', 'Juanita');*/
BEGIN
    INSERT INTO TEAM VALUES('John');
    INSERT INTO TEAM VALUES('Mary');
    INSERT INTO TEAM VALUES('Alberto');
    INSERT INTO TEAM VALUES('Juanita');

END;