CREATE OR REPLACE PACKAGE Pack_Grade_meaning1
AS
   FUNCTION PF_Grade_meaning1
   RETURN BOOLEAN;
   PROCEDURE PP_Grade_meaning1;
END Pack_Grade_meaning1;

CREATE OR REPLACE PACKAGE BODY Pack_Grade_meaning1
AS
       FUNCTION PF_Grade_meaning1
       RETURN BOOLEAN
       IS
         I NUMBER;
        BEGIN
            I := 0;
            LOOP
                I := I + 1;
                EXIT WHEN (I > 5);
            END LOOP;
        RETURN TRUE;
        END;

       PROCEDURE PP_Grade_meaning1
        IS
          I NUMBER;
        BEGIN
            I := 0;
            LOOP
                I := I + 1;
                EXIT WHEN (I > 5);
            END LOOP;
        END;
END Pack_Grade_meaning1;