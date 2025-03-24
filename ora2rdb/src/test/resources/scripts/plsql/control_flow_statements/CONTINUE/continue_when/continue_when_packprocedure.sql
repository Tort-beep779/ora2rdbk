CREATE PACKAGE PackP_Continue_When
AS
    PROCEDURE PP_Continue_When;
END;

CREATE PACKAGE BODY PackP_Continue_When
AS
    PROCEDURE PP_Continue_When
    IS
    BEGIN
      FOR i IN 1..3 LOOP
        CONTINUE WHEN i = 1;
      END LOOP;
    END;
END;