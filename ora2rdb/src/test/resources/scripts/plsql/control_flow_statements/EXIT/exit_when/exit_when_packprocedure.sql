CREATE PACKAGE PackP_Exit_When
AS
    PROCEDURE PP_Exit_When;
END;

CREATE PACKAGE BODY PackP_Exit_When
AS
    PROCEDURE PP_Exit_When
    IS
    BEGIN
      FOR i IN 1..3 LOOP
        EXIT WHEN i = 3;
      END LOOP;
    END;
END;