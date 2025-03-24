CREATE PACKAGE PackP_Exit
AS
    PROCEDURE PP_Exit;
END;

CREATE PACKAGE BODY PackP_Exit
AS
    PROCEDURE PP_Exit
    IS
    BEGIN
      FOR i IN 1..3 LOOP
        if i = 3 then 
          EXIT;
        end if;  
      END LOOP;
    END;
END;