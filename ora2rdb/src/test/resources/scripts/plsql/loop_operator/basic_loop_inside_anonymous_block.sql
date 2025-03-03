DECLARE
    I NUMBER;
BEGIN
    I := 0;
    LOOP
        I := I + 1;
        EXIT WHEN (I > 5);
    END LOOP;
END;