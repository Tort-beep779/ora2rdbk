CREATE PACKAGE PackP_Goto
AS
    PROCEDURE PP_Goto;
END;

CREATE PACKAGE BODY PackP_Goto
AS
    PROCEDURE PP_Goto
    IS
      i PLS_INTEGER;
    BEGIN
      GOTO first_label;
      i := 10; 
      <<first_label>>
      i := 1;
    END;
END;