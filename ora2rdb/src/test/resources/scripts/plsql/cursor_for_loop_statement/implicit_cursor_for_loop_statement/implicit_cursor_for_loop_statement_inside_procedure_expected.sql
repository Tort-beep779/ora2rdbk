CREATE PROCEDURE P_Grade_meaning1
    AS
    DECLARE VARIABLE ITEM_TEMP_CURSOR CURSOR FOR (SELECT LAST_NAME, EMP_NO
        FROM EMPLOYEE);

    DECLARE VARIABLE ITEM TYPE OF TABLE ITEM_TEMP_CURSOR;
BEGIN
    FOR (
        SELECT LAST_NAME, EMP_NO
        FROM EMPLOYEE
      ) INTO ITEM DO
        BEGIN

        END
END;