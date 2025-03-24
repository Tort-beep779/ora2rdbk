CREATE PACKAGE PackP_Continue_When
SQL SECURITY DEFINER
AS BEGIN
    PROCEDURE PP_Continue_When;
END;

CREATE PACKAGE BODY PackP_Continue_When
AS
BEGIN
    PROCEDURE PP_Continue_When
    AS
      DECLARE i_FOR1 INTEGER;
      DECLARE bound_i_FOR1 INTEGER;
    BEGIN
      i_FOR1 = 1;
      bound_i_FOR1 = 3;
      WHILE (i_FOR1 <= bound_i_FOR1) DO
      BEGIN 
        if (i_FOR1 = 1) then 
        BEGIN
          i_FOR1 = i_FOR1 + 1;
          CONTINUE;
        END
        i_FOR1 = i_FOR1 + 1;
      END
      i_FOR1 = bound_i_FOR1;
    END
END;