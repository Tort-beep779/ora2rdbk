


CREATE EXCEPTION NO_DATA_FOUND
	'no data found';
CREATE OR ALTER PACKAGE PACKAGE_1 AS BEGIN 


-----------------------------------------------------------------------------
-------------------- PUBLIC DECLARATIONS ------------------------------------
-----------------------------------------------------------------------------



  end ;


SET TERM ^ ;

RECREATE   PACKAGE BODY PACKAGE_NAME_1 AS BEGIN 

-----------------------------------------------------------------------------
-------------------- PRIVATE DECLARATIONS -----------------------------------
-----------------------------------------------------------------------------






-----------------------------------------------------------------------------
--------------------------- PACKAGE FUNCTIONS -------------------------------
-----------------------------------------------------------------------------

--FUNCTION Public_To_Table___ (
--   public_ IN Public_Rec ) RETURN cf_rep_customer_tab%ROWTYPE;




------------------- TEST_PACKAGE_FUNCTION_1 -------------------

FUNCTION TEST_PACKAGE_FUNCTION_1 (
    inputParameter_1 Public_Rec) RETURNS TYPE OF TABLE cf_rep_customer_tab
AS


  DECLARE VARIABLE Lcntr INTEGER;
BEGIN

    Lcntr = 1;
    WHILE ( Lcntr <= 20) DO
    BEGIN
       LCalc = :Lcntr * 31;
       dbms_output.put_line(LCalc);
    Lcntr = Lcntr + 1;
    END

END /*TEST_PACKAGE_FUNCTION_1*/  





------------------- TEST_PACKAGE_FUNCTION_2 -------------------

FUNCTION TEST_PACKAGE_FUNCTION_2 (
    inputParameter_1 Public_Rec) RETURNS TYPE OF TABLE cf_rep_customer_tab
AS


  DECLARE VARIABLE Lcntr INTEGER;
BEGIN

    Lcntr = 15;
    WHILE ( Lcntr  >=   1) DO
    BEGIN
       LCalc = :Lcntr * 31;
Lcntr = Lcntr - 1;
    END 

END /*TEST_PACKAGE_FUNCTION_2*/  



------------------- TEST_PACKAGE_FUNCTION_3 -------------------

FUNCTION TEST_PACKAGE_FUNCTION_3 (
    inputParameter_1 Public_Rec) RETURNS BOOLEAN
AS
     DECLARE done  BOOLEAN = FALSE;
BEGIN
    WHILE (:done) DO
    BEGIN
        DBMS_OUTPUT.PUT_LINE ('This line does not print.');
        done = TRUE;
    END  -- This assignment is not made.


    RETURN TRUE;

END /*TEST_PACKAGE_FUNCTION_3*/  




------------------- TEST_PACKAGE_FUNCTION_4 -------------------

PROCEDURE TEST_PACKAGE_FUNCTION_4 (
   in_outputParameter_1   Public_Rec) RETURNS (RET_VAL BOOLEAN, IN_OUTPUTPARAMETER_1_OUT Public_Rec)

AS
     DECLARE param_1 Public_Rec;
BEGIN
    param_1.column1 = 'new_text';
    in_outputParameter_1 = :param_1;
    RET_VAL = TRUE;
    IN_OUTPUTPARAMETER_1_OUT = IN_OUTPUTPARAMETER_1;
    SUSPEND;
    EXIT;

END /*TEST_PACKAGE_FUNCTION_4*/  



------------------- TEST_PACKAGE_FUNCTION_5 -------------------

FUNCTION TEST_PACKAGE_FUNCTION_5 (
    inputParameter_1 Public_Rec) RETURNS TYPE OF TABLE cf_rep_customer_tab
AS
     DECLARE deme boolean;
  
DECLARE TEST_PACKAGE_FUNCTION_4_RET_VAL BOOLEAN;
BEGIN
    WHILE ((TEST_PACKAGE_FUNCTION_4(:inputParameter_1))) DO
    BEGIN
        DBMS_OUTPUT.PUT_LINE (inputParameter_1.column1);
    END

END /*TEST_PACKAGE_FUNCTION_5*/  


------------------- TEST_PACKAGE_FUNCTION_6 -------------------

FUNCTION TEST_PACKAGE_FUNCTION_6 (
    inputParameter_1 Public_Rec) RETURNS TYPE OF TABLE cf_rep_customer_tab
AS

BEGIN
   FOR rec_ IN (SELECT column1, column2 FROM table1 WHERE column1 = 'text')
   DO
   BEGIN
        DBMS_OUTPUT.PUT_LINE (rec_.column1);
        DBMS_OUTPUT.PUT_LINE (rec_.column2);
   END

END /*TEST_PACKAGE_FUNCTION_6*/  



------------------- TEST_PACKAGE_FUNCTION_7 -------------------

FUNCTION TEST_PACKAGE_FUNCTION_7 (
    inputParameter_1 Public_Rec) RETURNS TYPE OF TABLE cf_rep_customer_tab
AS
     DECLARE text_  VARCHAR(1000);
    DECLARE cur1 CURSOR FOR
          (SELECT column1 column2
          FROM   table1
          WHERE  column1 = 'text');
  DECLARE VARIABLE CUR1_PKG TYPE OF TABLE CUR1;

BEGIN
    OPEN CUR1;
    FETCH CUR1 INTO CUR1_PKG;
    WHILE ( ROW_COUNT != 0 ) DO
    BEGIN
          text_ = rec_.column1 || '.' || rec_.column2;
          function_1(:text_);
    	FETCH CUR1 INTO CUR1_PKG;
    END
    CLOSE CUR1;


END /*TEST_PACKAGE_FUNCTION_7*/  



------------------- TEST_PACKAGE_FUNCTION_8 -------------------

FUNCTION TEST_PACKAGE_FUNCTION_8 (
    daily_value NUMERIC(18, 4)) RETURNS TYPE OF TABLE cf_rep_customer_tab
AS
     DECLARE monthly_value NUMERIC(18, 4);
BEGIN

    WHILE (TRUE) DO BEGIN
       monthly_value = :daily_value * 31;
         IF( :monthly_value > 4000 ) BEGIN LEAVE END;
    END 

END /*TEST_PACKAGE_FUNCTION_8*/  



------------------- TEST_PACKAGE_FUNCTION_9 -------------------

FUNCTION TEST_PACKAGE_FUNCTION_9 (
    inputParameter_1 Public_Rec) RETURNS TYPE OF TABLE cf_rep_customer_tab
AS
     DECLARE text_  VARCHAR(1000);
    DECLARE cur1 CURSOR FOR
          (SELECT column1 column2
          FROM   table1
          WHERE  column1 = 'text');

    DECLARE cur2 CURSOR FOR
          (SELECT column3 column4
          FROM   table1
          WHERE  column3 = 'text');
  DECLARE VARIABLE CUR1_C TYPE OF TABLE CUR1;

  DECLARE VARIABLE CUR1_PKG TYPE OF TABLE CUR1;

BEGIN
    OPEN CUR1;
    FETCH CUR1 INTO CUR1_PKG;
    WHILE ( ROW_COUNT != 0 ) DO
    BEGIN
          text_ = rec_.column1 || '.' || rec_.column2;
          function_1(:text_);
        OPEN CUR1;
        FETCH CUR1 INTO CUR1_C;
        WHILE ( ROW_COUNT != 0 ) DO
        BEGIN
              text_ = CUR1_C.column1 || '.' || CUR1_C.column2;
              function_1(:text_);
        	FETCH CUR1 INTO CUR1_C;
        END
        CLOSE CUR1;

    	FETCH CUR1 INTO CUR1_PKG;
    END
    CLOSE CUR1;

END /*TEST_PACKAGE_FUNCTION_9*/  



------------------- TEST_PACKAGE_FUNCTION_10 -------------------

--FUNCTION TEST_PACKAGE_FUNCTION_10 (
--    inputParameter_1 Public_Rec) RETURN cf_rep_customer_tab%ROWTYPE
--IS
--
--BEGIN
--
--
--END TEST_PACKAGE_FUNCTION_10;

  end ;

SET TERM ; ^





-----------------------------------------------------------------------------
------------------------------- FUNCTIONS -----------------------------------
-----------------------------------------------------------------------------


------------------- TEST_FUNCTION_1 -------------------

SET TERM ^ ;

CREATE FUNCTION TEST_FUNCTION_1 (
    inputParameter_1 Public_Rec ) RETURNS Public_Rec
AS
    DECLARE from_ NUMERIC(18, 4);
    DECLARE to_   NUMERIC(18, 4);

  DECLARE VARIABLE Lcntr INTEGER;
BEGIN
    Lcntr = 1;
    WHILE ( Lcntr <= 20) DO
    BEGIN
           LCalc = :Lcntr * 31;
           dbms_output.put_line(LCalc);
    Lcntr = Lcntr + 1;
    END
END /*TEST_FUNCTION_1*/^

SET TERM ; ^



----------------- TEST_FUNCTION_2 -------------------

SET TERM ^ ;

CREATE FUNCTION TEST_FUNCTION_2 (
    inputParameter_1 Public_Rec ) RETURNS Public_Rec
AS


  DECLARE VARIABLE Lcntr INTEGER;
BEGIN

    Lcntr = 15;
    WHILE ( Lcntr  >=   1) DO
    BEGIN
       LCalc = :Lcntr * 31;
Lcntr = Lcntr - 1;
    END 
END /*TEST_FUNCTION_2*/^

SET TERM ; ^



------------------- TEST_FUNCTION_3 -------------------

SET TERM ^ ;

CREATE FUNCTION TEST_FUNCTION_3 (
    inputParameter_1 Public_Rec ) RETURNS Public_Rec
AS
     DECLARE done  BOOLEAN = FALSE;
BEGIN
    WHILE (:done) DO
    BEGIN
        DBMS_OUTPUT.PUT_LINE ('This line does not print.');
        done = TRUE;
    END  -- This assignment is not made.

END /*TEST_FUNCTION_3*/^

SET TERM ; ^




------------------- TEST_FUNCTION_4 -------------------

SET TERM ^ ;

CREATE PROCEDURE TEST_FUNCTION_4 (
    in_outputParameter_1  Public_Rec ) RETURNS (RET_VAL BOOLEAN, IN_OUTPUTPARAMETER_1_OUT Public_Rec)

AS
     DECLARE param_1 Public_Rec;
BEGIN
    param_1.column1 = 'new_text';
      in_outputParameter_1 = :param_1;
      RET_VAL = TRUE;
      IN_OUTPUTPARAMETER_1_OUT = IN_OUTPUTPARAMETER_1;
      SUSPEND;
      EXIT;

END /*TEST_FUNCTION_4*/^

SET TERM ; ^



------------------- TEST_FUNCTION_5 -------------------

SET TERM ^ ;

CREATE FUNCTION TEST_FUNCTION_5 (
    inputParameter_1 Public_Rec ) RETURNS Public_Rec
AS
     DECLARE bool  BOOLEAN = FALSE;

  DECLARE TEST_FUNCTION_4_RET_VAL BOOLEAN;
BEGIN
    WHILE ((TEST_FUNCTION_4(:inputParameter_1))) DO
    BEGIN
            DBMS_OUTPUT.PUT_LINE (inputParameter_1.column1);
    END
END /*TEST_FUNCTION_5*/^

SET TERM ; ^



------------------- TEST_FUNCTION_6 -------------------

SET TERM ^ ;

CREATE FUNCTION TEST_FUNCTION_6 (
    inputParameter_1 Public_Rec ) RETURNS Public_Rec
AS

BEGIN
   FOR rec_ IN (SELECT column1, column2 FROM table1 WHERE column1 = 'text')
   DO
   BEGIN
        DBMS_OUTPUT.PUT_LINE (rec_.column1);
        DBMS_OUTPUT.PUT_LINE (rec_.column2);
   END
END /*TEST_FUNCTION_6*/^

SET TERM ; ^



------------------- TEST_FUNCTION_7 -------------------

SET TERM ^ ;

CREATE FUNCTION TEST_FUNCTION_7 (
    inputParameter_1 Public_Rec ) RETURNS Public_Rec
AS
     DECLARE text_  VARCHAR(1000);
    DECLARE cur1 CURSOR FOR
          (SELECT column1, column2
          FROM   table1
          WHERE  column1 = 'text');

  DECLARE VARIABLE CUR1_PKG TYPE OF TABLE CUR1;
BEGIN
    OPEN CUR1;
    FETCH CUR1 INTO CUR1_PKG;
    WHILE ( ROW_COUNT != 0 ) DO
    BEGIN
          text_ = rec_.column1 || '.' || rec_.column2;
          function_1(:text_);
    	FETCH CUR1 INTO CUR1_PKG;
    END
    CLOSE CUR1;


END /*TEST_FUNCTION_7*/^

SET TERM ; ^




------------------- TEST_FUNCTION_8 -------------------

SET TERM ^ ;

CREATE FUNCTION TEST_FUNCTION_8 (
    inputParameter_1 Public_Rec ) RETURNS Public_Rec
AS

BEGIN
    WHILE (TRUE) DO BEGIN
       monthly_value = daily_value * 31;
         IF( monthly_value > 4000 ) BEGIN LEAVE END;
    END 
END /*TEST_FUNCTION_8*/^

SET TERM ; ^



------------------- TEST_FUNCTION_9 -------------------

SET TERM ^ ;

CREATE FUNCTION TEST_FUNCTION_9 (
    inputParameter_1 Public_Rec ) RETURNS Public_Rec
AS
     DECLARE text_  VARCHAR(1000);
    DECLARE cur1 CURSOR FOR
          (SELECT column1 column2
          FROM   table1
          WHERE  column1 = 'text');

    DECLARE cur2 CURSOR FOR
          (SELECT column3 column4
          FROM   table1
          WHERE  column3 = 'text');

  DECLARE VARIABLE CUR1_C TYPE OF TABLE CUR1;

  DECLARE VARIABLE CUR1_PKG TYPE OF TABLE CUR1;
BEGIN
    OPEN CUR1;
    FETCH CUR1 INTO CUR1_PKG;
    WHILE ( ROW_COUNT != 0 ) DO
    BEGIN
          text_ = rec_.column1 || '.' || rec_.column2;
          function_1(:text_);
        OPEN CUR1;
        FETCH CUR1 INTO CUR1_C;
        WHILE ( ROW_COUNT != 0 ) DO
        BEGIN
              text_ = CUR1_C.column1 || '.' || CUR1_C.column2;
              function_1(:text_);
        	FETCH CUR1 INTO CUR1_C;
        END
        CLOSE CUR1;

    	FETCH CUR1 INTO CUR1_PKG;
    END
    CLOSE CUR1;

END /*TEST_FUNCTION_9*/^

SET TERM ; ^



------------------- TEST_FUNCTION_10 -------------------

--CREATE FUNCTION TEST_FUNCTION_10 (
--    inputParameter_1 Public_Rec ) RETURN Public_Rec
--IS
--
--BEGIN
--
--END TEST_FUNCTION_10;

-----------------------------------------------------------------------------
------------------------------ PROCEDURES -----------------------------------
-----------------------------------------------------------------------------


------------------- TEST_PROCEDURE_1 -------------------

    SET TERM ^ ;

CREATE PROCEDURE TEST_PROCEDURE_1 (
        inputParameter_1 VARCHAR(32000),
        inputParameter_2 VARCHAR(32000)
    )
    AS

    
  DECLARE VARIABLE Lcntr INTEGER;
BEGIN
       Lcntr = 1;
       WHILE ( Lcntr <= 20) DO
       BEGIN
              LCalc = :Lcntr * 31;
              dbms_output.put_line(LCalc);
       Lcntr = Lcntr + 1;
       END
    END /*TEST_PROCEDURE_1*/^

SET TERM ; ^




    ------------------- TEST_PROCEDURE_2 -------------------

    SET TERM ^ ;

CREATE PROCEDURE TEST_PROCEDURE_2 (
         inputParameter_1 VARCHAR(32000),
         nputParameter_2 VARCHAR(32000)
        )
    AS

    
  DECLARE VARIABLE Lcntr INTEGER;
BEGIN
        Lcntr = 15;
        WHILE ( Lcntr  >=   1) DO
        BEGIN
           LCalc = :Lcntr * 31;
Lcntr = Lcntr - 1;
        END 
    END /*TEST_PROCEDURE_2*/^

SET TERM ; ^




    ------------------- TEST_PROCEDURE_3 -------------------

    SET TERM ^ ;

CREATE PROCEDURE TEST_PROCEDURE_3 (
        inputParameter_1 VARCHAR(32000),
        inputParameter_2 VARCHAR(32000)
    )
    AS
         DECLARE done  BOOLEAN = FALSE;

    BEGIN

        WHILE (:done) DO
        BEGIN
            DBMS_OUTPUT.PUT_LINE ('This line does not print.');
            done = TRUE;
        END  -- This assignment is not made.


    END /*TEST_PROCEDURE_3*/^

SET TERM ; ^



    ------------------- TEST_PROCEDURE_4 -------------------
    SET TERM ^ ;

CREATE PROCEDURE TEST_PROCEDURE_4 (
        inputParameter_1 VARCHAR(32000),
        inputParameter_2 VARCHAR(32000),
        inputParameter_1 Public_Rec
    )
    AS

    BEGIN
      WHILE ((TEST_FUNCTION_4(:inputParameter_1))) DO
      BEGIN
                DBMS_OUTPUT.PUT_LINE (inputParameter_1.column1);
      END
    END /*TEST_PROCEDURE_4*/^

SET TERM ; ^



    ----------------- TEST_PROCEDURE_5 -------------------

    SET TERM ^ ;

CREATE PROCEDURE TEST_PROCEDURE_5 (
        inputParameter_1 VARCHAR(32000),
        inputParameter_2 VARCHAR(32000)
    )
    AS

    BEGIN
       FOR rec_ IN (SELECT column1, column2 FROM table1 WHERE column1 = 'text')
       DO
       BEGIN
            DBMS_OUTPUT.PUT_LINE (rec_.column1);
            DBMS_OUTPUT.PUT_LINE (rec_.column2);
       END
    END /*TEST_PROCEDURE_5*/^

SET TERM ; ^


    ------------------- TEST_PROCEDURE_6 -------------------

    SET TERM ^ ;

CREATE PROCEDURE TEST_PROCEDURE_6 (
        inputParameter_1 VARCHAR(32000),
        inputParameter_2 VARCHAR(32000)
    )
    AS
         DECLARE text_  VARCHAR(1000);
        DECLARE cur1 CURSOR FOR
              (SELECT column1 column2
              FROM   table1
              WHERE  column1 = 'text');
    
  DECLARE VARIABLE CUR1_PKG TYPE OF TABLE CUR1;
BEGIN
        OPEN CUR1;
        FETCH CUR1 INTO CUR1_PKG;
        WHILE ( ROW_COUNT != 0 ) DO
        BEGIN
              text_ = rec_.column1 || '.' || rec_.column2;
              function_1(:text_);
        	FETCH CUR1 INTO CUR1_PKG;
        END
        CLOSE CUR1;

    END /*TEST_PROCEDURE_6*/^

SET TERM ; ^



    ------------------- TEST_PROCEDURE_7 -------------------

    SET TERM ^ ;

CREATE PROCEDURE TEST_PROCEDURE_7 (
        inputParameter_1 VARCHAR(32000),
        inputParameter_2 VARCHAR(32000)
    )
    AS

    BEGIN
        WHILE (TRUE) DO BEGIN
           monthly_value = daily_value * 31;
             IF( monthly_value > 4000 ) BEGIN LEAVE END;
        END 
    END /*TEST_PROCEDURE_7*/^

SET TERM ; ^



    ------------------- TEST_PROCEDURE_8 -------------------

--    CREATE PROCEDURE TEST_PROCEDURE_8 (
--        inputParameter_1 VARCHAR2(32000),
--        inputParameter_2 VARCHAR2(32000)
--    )
--    IS
--
--    BEGIN
--
--    END TEST_PROCEDURE_8;




    ------------------- TEST_PROCEDURE_8 -------------------

    SET TERM ^ ;

CREATE PROCEDURE TEST_PROCEDURE_8 (
        inputParameter_1 VARCHAR(32000),
        inputParameter_2 VARCHAR(32000)
    )
    AS
         DECLARE text_  VARCHAR(1000);
        DECLARE cur1 CURSOR FOR
              (SELECT column1 column2
              FROM   table1
              WHERE  column1 = 'text');

        DECLARE cur2 CURSOR FOR
              (SELECT column3 column4
              FROM   table1
              WHERE  column3 = 'text');
    
  DECLARE VARIABLE CUR1_C TYPE OF TABLE CUR1;

  DECLARE VARIABLE CUR1_PKG TYPE OF TABLE CUR1;
BEGIN
        OPEN CUR1;
        FETCH CUR1 INTO CUR1_PKG;
        WHILE ( ROW_COUNT != 0 ) DO
        BEGIN
              text_ = rec_.column1 || '.' || rec_.column2;
              function_1(:text_);
            OPEN CUR1;
            FETCH CUR1 INTO CUR1_C;
            WHILE ( ROW_COUNT != 0 ) DO
            BEGIN
                  text_ = CUR1_C.column1 || '.' || CUR1_C.column2;
                  function_1(:text_);
            	FETCH CUR1 INTO CUR1_C;
            END
            CLOSE CUR1;

        	FETCH CUR1 INTO CUR1_PKG;
        END
        CLOSE CUR1;

    END /*TEST_PROCEDURE_8*/^

SET TERM ; ^


SET TERM ^ ;

RECREATE   PACKAGE BODY PACKAGE_NAME_2 AS BEGIN 


------------------- TEST_PACKAGE_PROCEDURE_1 -------------------

    PROCEDURE TEST_PACKAGE_PROCEDURE_1 (
       inputParameter_1 VARCHAR(32000),
       inputParameter_2 VARCHAR(32000)
   )
   AS

   
  DECLARE VARIABLE Lcntr INTEGER;
BEGIN
      Lcntr = 1;
      WHILE ( Lcntr <= 20) DO
      BEGIN
             LCalc = :Lcntr * 31;
             dbms_output.put_line(LCalc);
      Lcntr = Lcntr + 1;
      END
   END /*TEST_PACKAGE_PROCEDURE_1*/  





------------------- TEST_PACKAGE_PROCEDURE_2 -------------------

    PROCEDURE TEST_PACKAGE_PROCEDURE_2 (
       inputParameter_1 VARCHAR(32000),
       inputParameter_2 VARCHAR(32000)
   )
   AS
         DECLARE done  BOOLEAN = FALSE;
   
  DECLARE VARIABLE Lcntr INTEGER;
BEGIN

        Lcntr = 15;
        WHILE ( Lcntr  >=   1) DO
        BEGIN
           LCalc = :Lcntr * 31;
Lcntr = Lcntr - 1;
        END 

   END /*TEST_PACKAGE_PROCEDURE_2*/  



------------------- TEST_PACKAGE_PROCEDURE_3 -------------------

    PROCEDURE TEST_PACKAGE_PROCEDURE_3 (
       inputParameter_1 VARCHAR(32000),
       inputParameter_2 VARCHAR(32000)
   )
   AS

   BEGIN

      WHILE (done) DO
      BEGIN
          DBMS_OUTPUT.PUT_LINE ('This line does not print.');
          done = TRUE;
      END  -- This assignment is not made.


   END /*TEST_PACKAGE_PROCEDURE_3*/  



------------------- TEST_PACKAGE_PROCEDURE_4 -------------------

    PROCEDURE TEST_PACKAGE_PROCEDURE_4 (
       inputParameter_1 VARCHAR(32000),
       inputParameter_2 VARCHAR(32000),
       inputParameter_1 Public_Rec
   )
   AS

   BEGIN
      WHILE ((TEST_FUNCTION_4(:inputParameter_1))) DO
      BEGIN
                DBMS_OUTPUT.PUT_LINE (inputParameter_1.column1);
      END

   END /*TEST_PACKAGE_PROCEDURE_4*/  



------------------- TEST_PACKAGE_PROCEDURE_5 -------------------

    PROCEDURE TEST_PACKAGE_PROCEDURE_5 (
       inputParameter_1 VARCHAR(32000),
       inputParameter_2 VARCHAR(32000)
   )
   AS

   BEGIN
       FOR rec_ IN (SELECT column1, column2 FROM table1 WHERE column1 = 'text')
       DO
       BEGIN
            DBMS_OUTPUT.PUT_LINE (rec_.column1);
            DBMS_OUTPUT.PUT_LINE (rec_.column2);
       END

   END /*TEST_PACKAGE_PROCEDURE_5*/  



------------------- TEST_PACKAGE_PROCEDURE_6 -------------------

    PROCEDURE TEST_PACKAGE_PROCEDURE_6 (
       inputParameter_1 VARCHAR(32000),
       inputParameter_2 VARCHAR(32000)
   )
   AS
         DECLARE text_  VARCHAR(1000);
        DECLARE cur1 CURSOR FOR
              (SELECT column1 column2
              FROM   table1
              WHERE  column1 = 'text');
   
  DECLARE VARIABLE CUR1_PKG TYPE OF TABLE CUR1;
BEGIN
        OPEN CUR1;
        FETCH CUR1 INTO CUR1_PKG;
        WHILE ( ROW_COUNT != 0 ) DO
        BEGIN
              text_ = rec_.column1 || '.' || rec_.column2;
              function_1(:text_);
        	FETCH CUR1 INTO CUR1_PKG;
        END
        CLOSE CUR1;


   END /*TEST_PACKAGE_PROCEDURE_6*/  



------------------- TEST_PACKAGE_PROCEDURE_7 -------------------

    PROCEDURE TEST_PACKAGE_PROCEDURE_7 (
       inputParameter_1 VARCHAR(32000),
       inputParameter_2 VARCHAR(32000)
   )
   AS

   BEGIN
        WHILE (TRUE) DO BEGIN
           monthly_value = daily_value * 31;
             IF( monthly_value > 4000 ) BEGIN LEAVE END;
        END 

   END /*TEST_PACKAGE_PROCEDURE_7*/  



--------------------- TEST_PACKAGE_PROCEDURE_8 -------------------

    PROCEDURE TEST_PACKAGE_PROCEDURE_8 (
       inputParameter_1 VARCHAR(32000),
       inputParameter_2 VARCHAR(32000)
   )
   AS
        DECLARE text_  VARCHAR(1000);
       DECLARE cur1 CURSOR FOR
             (SELECT column1 column2
             FROM   table1
             WHERE  column1 = 'text');

       DECLARE cur2 CURSOR FOR
             (SELECT column3 column4
             FROM   table1
             WHERE  column3 = 'text');

   
  DECLARE VARIABLE CUR1_C TYPE OF TABLE CUR1;

  DECLARE VARIABLE CUR1_PKG TYPE OF TABLE CUR1;
BEGIN
        OPEN CUR1;
        FETCH CUR1 INTO CUR1_PKG;
        WHILE ( ROW_COUNT != 0 ) DO
        BEGIN
              text_ = rec_.column1 || '.' || rec_.column2;
              function_1(:text_);
            OPEN CUR1;
            FETCH CUR1 INTO CUR1_C;
            WHILE ( ROW_COUNT != 0 ) DO
            BEGIN
                  text_ = CUR1_C.column1 || '.' || CUR1_C.column2;
                  function_1(:text_);
            	FETCH CUR1 INTO CUR1_C;
            END
            CLOSE CUR1;

        	FETCH CUR1 INTO CUR1_PKG;
        END
        CLOSE CUR1;



   END /*TEST_PACKAGE_PROCEDURE_8*/  




------------------- TEST_PACKAGE_PROCEDURE_9 -------------------
--
--    PROCEDURE TEST_PACKAGE_PROCEDURE_9 (
--       inputParameter_1 VARCHAR2(32000),
--       inputParameter_2 VARCHAR2(32000)
--   )
--   IS
--
--   BEGIN
--
--
--   END TEST_PACKAGE_PROCEDURE_9;

  end ;

SET TERM ; ^
