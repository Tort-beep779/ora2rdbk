CREATE PACKAGE PackP_Exit_When
SQL SECURITY DEFINER
AS BEGIN
    PROCEDURE PP_Exit_When;
END;

CREATE PACKAGE BODY PackP_Exit_When
AS
BEGIN
    PROCEDURE PP_Exit_When
    AS
      DECLARE i_FOR1 INTEGER;
      DECLARE bound_i_FOR1 INTEGER;
    BEGIN
      i_FOR1 = 1;
      bound_i_FOR1 = 3;
      WHILE (i_FOR1 <= bound_i_FOR1) DO
      BEGIN 
        if (i_FOR1 = 3) then 
          LEAVE;
        i_FOR1 = i_FOR1 + 1;
      END
      i_FOR1 = bound_i_FOR1;
    END
END;