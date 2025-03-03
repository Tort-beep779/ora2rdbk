CREATE OR REPLACE PACKAGE Pack_Grade_meaning1
AS
   FUNCTION PF_Grade_meaning1 (degree INTEGER)
   RETURN BOOLEAN;
   PROCEDURE PP_Grade_meaning1;

    CURSOR BOOKS_CUR RETURN BOOKS%ROWTYPE;

    CURSOR C1 IS
        SELECT LAST_NAME, JOB_ID FROM EMPLOYEES
        WHERE MANAGER_ID > 120
        ORDER BY LAST_NAME;

END Pack_Grade_meaning1;

CREATE OR REPLACE PACKAGE BODY Pack_Grade_meaning1
AS

    CURSOR BOOKS_CUR
        RETURN BOOKS%ROWTYPE
            IS
        SELECT BOOK_NAME
        FROM BOOKS;

    FUNCTION PF_Grade_meaning1 (degree INTEGER)
       RETURN BOOLEAN
       IS
    BEGIN
        FOR ITEM IN C1
            LOOP
                NULL;
            END LOOP;
    RETURN TRUE;
    END;

    PROCEDURE PP_Grade_meaning1
    IS
    BEGIN
        FOR ITEM IN BOOKS_CUR
            LOOP
                NULL;
            END LOOP;
    END;
END Pack_Grade_meaning1;




