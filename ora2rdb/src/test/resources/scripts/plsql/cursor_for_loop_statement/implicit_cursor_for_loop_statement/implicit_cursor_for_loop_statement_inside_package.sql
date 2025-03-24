CREATE OR REPLACE PACKAGE Pack_Grade_meaning1
AS
   FUNCTION PF_Grade_meaning1 (degree INTEGER)
   RETURN BOOLEAN;
   PROCEDURE PP_Grade_meaning1;
END Pack_Grade_meaning1;

CREATE OR REPLACE PACKAGE BODY Pack_Grade_meaning1
AS
    FUNCTION PF_Grade_meaning1 (degree INTEGER)
    RETURN BOOLEAN
    IS
    BEGIN
        FOR ITEM IN (
                SELECT LAST_NAME, EMP_NO
                FROM EMPLOYEE
              )
                LOOP
                    NULL;
        END LOOP;
        RETURN TRUE;
    END;

    PROCEDURE PP_Grade_meaning1
    IS
    BEGIN
        FOR ITEM IN (
                    SELECT LAST_NAME, EMP_NO
                    FROM EMPLOYEE
                  )
                    LOOP
                        NULL;
        END LOOP;
    END;
END Pack_Grade_meaning1;