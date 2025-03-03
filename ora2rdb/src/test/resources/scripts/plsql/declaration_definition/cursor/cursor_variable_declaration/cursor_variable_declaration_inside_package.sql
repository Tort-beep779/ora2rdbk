-- Объявление внутри заголовка пакета
CREATE PACKAGE BOOK_INFO
IS
    CURSOR cur IS
    SELECT * FROM employees;
    cur_rec cur%ROWTYPE;
END;

CREATE PACKAGE BODY BOOK_INFO
IS

END;

-- Объявление курсора в заголовке пакета , а переменной внутри тела пакета
CREATE OR REPLACE PACKAGE BOOK_INFO
IS
    CURSOR cur IS
SELECT * FROM employees;

END;

CREATE OR REPLACE PACKAGE BODY BOOK_INFO
IS
    cur_rec cur%ROWTYPE;
END;


-- Объявление курсора и переменной в теле пакета
CREATE OR REPLACE PACKAGE BOOK_INFO
IS

END;

CREATE OR REPLACE PACKAGE BODY BOOK_INFO
IS
    CURSOR cur IS
SELECT * FROM employees;
cur_rec cur%ROWTYPE;
END;

-- Объявление в функции в пакете
CREATE OR REPLACE PACKAGE BOOK_INFO
IS
    FUNCTION TEST_F RETURN BOOLEAN;
END;

CREATE OR REPLACE PACKAGE BODY BOOK_INFO
IS
    FUNCTION TEST_F
    RETURN BOOLEAN
    IS
        CURSOR CUR IS
            SELECT * FROM EMPLOYEES;
        CUR_REC CUR%ROWTYPE;
    BEGIN

        RETURN TRUE;
    END;

END;
