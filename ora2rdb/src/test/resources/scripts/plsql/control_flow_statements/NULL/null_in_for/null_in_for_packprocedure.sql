CREATE PACKAGE PackP_Null_In_For
AS
    PROCEDURE PP_Null_In_For;
END;

CREATE PACKAGE BODY PackP_Null_In_For
AS
    PROCEDURE PP_Null_In_For
    IS
    BEGIN
      FOR i IN 1..3
      LOOP
        NULL;
      END LOOP;
    END;
END;