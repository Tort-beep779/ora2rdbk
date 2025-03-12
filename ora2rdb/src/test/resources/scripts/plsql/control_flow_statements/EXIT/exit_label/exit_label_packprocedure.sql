CREATE PACKAGE PackP_Exit_Label
AS
    PROCEDURE PP_Exit_Label;
END;

CREATE PACKAGE BODY PackP_Exit_Label
AS
  PROCEDURE PP_Exit_Label
  IS
    x NUMBER := 0;
  BEGIN
    <<loop1>>
    LOOP
      x := x + 1;
      IF x > 4 THEN
        EXIT loop1;
      END IF;
    END LOOP;
    END;
END;