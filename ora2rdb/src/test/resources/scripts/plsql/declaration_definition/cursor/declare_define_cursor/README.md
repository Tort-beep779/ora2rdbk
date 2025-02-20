В тестах демонстирутся примеры объявления и инициализации курсора 

Объявить курсор командой 

    CURSOR CURSOR_NAME RETURN EMPLOYEES%ROWTYPE;

В РБД нельзя. Кусор должен быть сразу инициализирован. 

При конвертации объявление курсора комментируется


------------------------

### [define_declare_inside_package.sql](define_declare_inside_package.sql)

В тесте демонстируется пример объявления и инициализации внутри загаловка и теал пакета. 

Ожидаемый результат после конвертации 

    -- инициализация внутри PACKAGE и объявление внутри PACKAGE BODY
    /*CANNOT DECLARE CURSOR INSIDE PACKAGE DECLARATION*/
    CREATE PACKAGE BOOK_INFO
    AS BEGIN
        /*CURSOR BOOKS_CUR RETURN BOOKS%ROWTYPE;*/
    END;
    
    /*CANNOT CREATE CURSOR IN PACKAGE BODY*/
    CREATE PACKAGE BODY BOOK_INFO
    AS BEGIN
        /*CURSOR BOOKS_CUR
        RETURN BOOKS%ROWTYPE
        IS
            SELECT *
            FROM BOOKS;*/
    END;
    
    -- инициализация и объявление внутри PACKAGE BODY
    CREATE PACKAGE BOOK_INFO
    AS BEGIN
    
    END;
    
    /*CANNOT CREATE CURSOR IN PACKAGE BODY*/
    CREATE PACKAGE BODY BOOK_INFO
    AS BEGIN
        /*CURSOR BOOKS_CUR RETURN BOOKS%ROWTYPE;*/
        /*CURSOR BOOKS_CUR
        RETURN BOOKS%ROWTYPE
        IS
            SELECT *
            FROM BOOKS;*/
    END;
    
    -- инициализация и объявление внутри PACKAGE
    /*CANNOT DECLARE CURSOR INSIDE PACKAGE DECLARATION*/
    CREATE PACKAGE BOOK_INFO
    AS BEGIN
        /*CURSOR BOOKS_CUR RETURN BOOKS%ROWTYPE;*/
        /*CURSOR BOOKS_CUR
        RETURN BOOKS%ROWTYPE
        IS
            SELECT *
            FROM BOOKS;*/
    END;
    
    CREATE PACKAGE BODY BOOK_INFO
    AS BEGIN
    
    END;

    -- объявление и инициализация в функции внутри пакета
    CREATE OR ALTER PACKAGE BOOK_INFO
    AS BEGIN
        FUNCTION TEST_F RETURNS BOOLEAN;  
    END;

    RECREATE   PACKAGE BODY BOOK_INFO
    AS BEGIN
        FUNCTION TEST_F
        RETURNS BOOLEAN
        AS
            /*DECLARE BOOKS_CUR RETURN TYPE OF TABLE BOOKS;*/
            DECLARE BOOKS_CUR CURSOR FOR
                (SELECT *FROM BOOKS);
        BEGIN
    
        RETURN TRUE;
        END  
    END;

--------------------------------

