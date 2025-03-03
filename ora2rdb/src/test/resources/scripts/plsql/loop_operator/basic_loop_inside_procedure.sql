CREATE PROCEDURE P_Grade_meaning1
    IS
    I NUMBER;
BEGIN
    I := 0;
    LOOP
        I := I + 1;
        EXIT WHEN (I > 5);
    END LOOP;
END;