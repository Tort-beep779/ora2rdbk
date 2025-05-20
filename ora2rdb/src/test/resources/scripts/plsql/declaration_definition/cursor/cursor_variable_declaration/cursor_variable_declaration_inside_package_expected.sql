-- Объявление внутри заголовка пакета
/*CANNOT DECLARE CURSOR INSIDE PACKAGE DECLARATION*/
CREATE PACKAGE BOOK_INFO
AS BEGIN
    /*[-unconvertible DECLARE cur CURSOR FOR
    (SELECT * FROM employees)];*/
    /*[-unconvertible DECLARE VARIABLE cur_rec TYPE OF TABLE cur];*/
END;

CREATE PACKAGE BODY BOOK_INFO
AS BEGIN

END;

-- Объявление курсора в заголовке пакета , а переменной внутри тела пакета
/*CANNOT DECLARE CURSOR INSIDE PACKAGE DECLARATION*/
CREATE PACKAGE BOOK_INFO
AS BEGIN
    /*[-unconvertible DECLARE cur CURSOR FOR
            (SELECT * FROM employees)];*/
END;

CREATE PACKAGE BODY BOOK_INFO
AS BEGIN
    /*[-unconvertible DECLARE VARIABLE cur_rec TYPE OF TABLE cur];*/
END;

-- Объявление курсора и переменной в теле пакета
CREATE PACKAGE BOOK_INFO
AS BEGIN

END;

/*CANNOT CREATE CURSOR IN PACKAGE BODY*/
CREATE PACKAGE BODY BOOK_INFO
AS BEGIN
    /*[-unconvertible DECLARE cur CURSOR FOR
        (SELECT * FROM employees)];*/
    /*[-unconvertible DECLARE VARIABLE cur_rec TYPE OF TABLE cur];*/
END;


-- Объявление в функции в пакете
CREATE OR ALTER PACKAGE BOOK_INFO
AS BEGIN
    FUNCTION TEST_F RETURNS BOOLEAN;
END;

RECREATE PACKAGE BODY BOOK_INFO
AS BEGIN
    FUNCTION TEST_F
        RETURNS BOOLEAN
    AS

        DECLARE cur CURSOR FOR
            (SELECT * FROM employees);

        DECLARE VARIABLE cur_rec  TYPE OF TABLE cur;
    BEGIN

    RETURN TRUE;
    END
END;