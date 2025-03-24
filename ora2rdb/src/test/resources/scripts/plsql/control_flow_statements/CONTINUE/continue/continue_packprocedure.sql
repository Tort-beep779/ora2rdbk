CREATE PACKAGE PackP_Continue
AS
    PROCEDURE PP_Continue;
END;

CREATE PACKAGE BODY PackP_Continue
AS
    PROCEDURE PP_Continue
    IS
    BEGIN
      FOR i IN 1..3 LOOP
        if i = 1 then 
          CONTINUE;
        end if;  
      END LOOP;
    END;
END;