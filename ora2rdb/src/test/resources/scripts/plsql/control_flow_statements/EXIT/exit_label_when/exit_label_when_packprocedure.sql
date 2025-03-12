CREATE PACKAGE PackP_Exit_Label_When
AS
    PROCEDURE PP_Exit_Label_When;
END;

CREATE PACKAGE BODY PackP_Exit_Label_When
AS
  PROCEDURE PP_Exit_Label_When
  IS
    x NUMBER := 0;
  BEGIN
    <<while1>>
    WHILE (x != 5) LOOP
      x := x + 1;
      EXIT while1 WHEN x > 4;
    END LOOP;
  END;
END;