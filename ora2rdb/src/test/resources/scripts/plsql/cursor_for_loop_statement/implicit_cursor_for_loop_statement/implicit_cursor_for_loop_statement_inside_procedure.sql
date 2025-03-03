CREATE PROCEDURE P_Grade_meaning1
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