CREATE PACKAGE PackP_Null_In_For
SQL SECURITY DEFINER
AS BEGIN
    PROCEDURE PP_Null_In_For;
END;

CREATE PACKAGE BODY PackP_Null_In_For
AS
BEGIN
    PROCEDURE PP_Null_In_For
    AS
      DECLARE i_FOR1 INTEGER;
      DECLARE bound_i_FOR1 INTEGER;
    BEGIN
      i_FOR1 = 1;
      bound_i_FOR1 = 3;
      WHILE (i_FOR1 <= bound_i_FOR1) DO
      BEGIN 
          i_FOR1 = i_FOR1 + 1;
      END
      i_FOR1 = bound_i_FOR1;
    END
END;