/*Found error(s) in file while parsing
Error at line 10:6 - no viable alternative at input 'l_local_variable                -- MY ERROR -> missed "IF"\n      THEN'
Error at line 4:39 - no viable alternative at input 'FUNCTION my_function (param1    IN INTEGER\n                       , in_param2 INS DATE'
Error at line 7:9 - mismatched input '(' expecting ';'
Error at line 2:0 - no viable alternative at input 'END'
Error at line 2:21 - no viable alternative at input 'FUNCTION my_array RURN'
Error at line 3:35 - mismatched input '(' expecting ';'
Error at line 12:25 - mismatched input '(' expecting {<EOF>, ';'}
Error at line 4:6 - no viable alternative at input 'FUNCTION getcell                                                -- MY ERROR -> missed "("\n      array_in'
Error at line 13:36 - mismatched input '(' expecting {<EOF>, ';'}
Error at line 7:11 - mismatched input '..' expecting '.'
Error at line 12:6 - mismatched input 'THEN' expecting '.'
Error at line 14:4 - no viable alternative at input 'VALS'
Error at line 2:31 - no viable alternative at input 'FUNCTION format_call_stack  VARCHAR2'
Error at line 3:7 - no viable alternative at input 'FUNCTION format_call_stack\n       VARCHAR2'
*/





CREATE EXCEPTION NO_DATA_FOUND
	'no data found';
CREATE OR ALTER PACKAGE 
   AUTHID DEFINER
AS BEGIN 
   FUNCTION format_call_stack RETURNS VARCHAR(32000);  
   FUNCTION format_error_stack RETURNS VARCHAR(32000);  
   FUNCTION format_error_backtrace RETURNS VARCHAR(32000);  
   FUNCTION backtrace_to RETURNS VARCHAR(32000);  
  END;



CREATE OR ALTER PACKAGE 
   AUTHID DEFINER
AS BEGIN 
   PROCEDURE p;  
  END;



SET TERM ^ ;

RECREATE   PACKAGE BODY 
AS BEGIN 
   PROCEDURE p
   AS
BEGIN
      p1;
END  
  END;

SET TERM ; ^



CREATE OR ALTER PACKAGE dbms_errlog_helper
   AUTHID CURRENT_USER
AS BEGIN 
   PROCEDURE create_objects (dml_table_name           VARCHAR(32000)
                           , err_log_table_name       VARCHAR(32000) DEFAULT NULL
                           , err_log_table_owner      VARCHAR(32000) DEFAULT NULL
                           , err_log_table_space      VARCHAR(32000) DEFAULT NULL
                           , skip_unsupported         BOOLEAN DEFAULT FALSE
                           , overwrite_log_table      BOOLEAN DEFAULT TRUE
                           , err_log_package_name     VARCHAR(32000) DEFAULT NULL
                           , err_log_package_spec  DBMS_SQL.varchar2s
                           , err_log_package_body  DBMS_SQL.varchar2s
                            );  

   PROCEDURE create_objects (dml_table_name           VARCHAR(32000)
                           , err_log_table_name       VARCHAR(32000) DEFAULT NULL
                           , err_log_table_owner      VARCHAR(32000) DEFAULT NULL
                           , err_log_table_space      VARCHAR(32000) DEFAULT NULL
                           , skip_unsupported         BOOLEAN DEFAULT FALSE
                           , overwrite_log_table      BOOLEAN DEFAULT TRUE
                           , err_log_package_name     VARCHAR(32000) DEFAULT NULL
                           , err_log_package_spec  VARCHAR(32000)
                           , err_log_package_body  VARCHAR(32000)
                            );  

   PROCEDURE create_objects (dml_table_name        VARCHAR(32000)
                           , err_log_table_name    VARCHAR(32000) DEFAULT NULL
                           , err_log_table_owner   VARCHAR(32000) DEFAULT NULL
                           , err_log_table_space   VARCHAR(32000) DEFAULT NULL
                           , skip_unsupported      BOOLEAN DEFAULT FALSE
                           , overwrite_log_table   BOOLEAN DEFAULT TRUE
                           , err_log_package_name  VARCHAR(32000) DEFAULT NULL
                            );  
  END ;



SET TERM ^ ;

RECREATE   PACKAGE BODY dbms_errlog_helper
AS BEGIN 
   SUBTYPE maxvarchar2_t IS VARCHAR (32767);  

   PROCEDURE create_objects (dml_table_name           VARCHAR(32000)
                           , err_log_table_name       VARCHAR(32000) DEFAULT NULL
                           , err_log_table_owner      VARCHAR(32000) DEFAULT NULL
                           , err_log_table_space      VARCHAR(32000) DEFAULT NULL
                           , skip_unsupported         BOOLEAN DEFAULT FALSE
                           , overwrite_log_table      BOOLEAN DEFAULT TRUE
                           , err_log_package_name     VARCHAR(32000) DEFAULT NULL
                           , err_log_package_spec  DBMS_SQL.varchar2s
                           , err_log_package_body  DBMS_SQL.varchar2s
                            )
     RETURNS(      ERR_LOG_PACKAGE_SPEC_OUT DBMS_SQL.varchar2s, 
     ERR_LOG_PACKAGE_BODY_OUT DBMS_SQL.varchar2s)

AS
      
      DECLARE c_package_name CONSTANT maxvarchar2_t
            = SUBSTRING (COALESCE (:err_log_package_name, 'ELP$_' || :dml_table_name)
                      FROM  1
                      FOR  30
                      ) ;
      DECLARE c_errlog_table_name CONSTANT maxvarchar2_t
            = SUBSTRING (COALESCE (:err_log_table_name, 'ERR$_' || :dml_table_name)
                      FROM  1
                      FOR  30
                      ) ;
      DECLARE c_qual_errlog_table_name CONSTANT maxvarchar2_t
            = CASE
                  WHEN :err_log_table_owner IS NULL THEN NULL
                  ELSE :err_log_table_owner || '.'
END
|| :c_errlog_table_name ;
      DECLARE l_spec   DBMS_SQL.varchar2s;
      DECLARE l_body   DBMS_SQL.varchar2s;

      PROCEDURE create_error_log
AS
BEGIN
         IF (:overwrite_log_table)
         THEN
BEGIN
EXECUTE STATEMENT ('DROP TABLE ' || :c_qual_errlog_table_name);
/*EXCEPTION*/
               WHEN OTHERS
               DO
                  BEGIN
	                  NULL;
                  END
END
 
         DBMS_ERRLOG.create_error_log (
            :dml_table_name        => :dml_table_name
          , :err_log_table_name    => :err_log_table_name
          , :err_log_table_owner   => :err_log_table_owner
          , :err_log_table_space   => :err_log_table_space
          , :skip_unsupported      => :skip_unsupported
         );

         /* Alter the error log table to add audit columns. */
EXECUTE STATEMENT ('ALTER TABLE ' || COALESCE (:err_log_table_owner, USER)
    || '.' || :c_errlog_table_name || ' ADD created_by VARCHAR2(30)');

EXECUTE STATEMENT ('ALTER TABLE ' || COALESCE (:err_log_table_owner, USER)
    || '.' || :c_errlog_table_name || ' ADD created_on DATE');

/* Add Call Stack: Thanks, IFMC! */
EXECUTE STATEMENT ('ALTER TABLE ' || COALESCE (:err_log_table_owner, USER)
    || '.' || :c_errlog_table_name || ' ADD call_stack VARCHAR2(4000)');

/* Add the trigger to update these columns. */
EXECUTE STATEMENT ('CREATE OR REPLACE TRIGGER '
    || SUBSTRING (:dml_table_name || '$BEF_EL' FROM  1 FOR  30)
    || ' BEFORE INSERT OR UPDATE ON ' || COALESCE (:err_log_table_owner, USER)
    || '.' || :c_errlog_table_name || ' FOR EACH ROW BEGIN :NEW.created_by := USER; '
    || ' :NEW.created_on := SYSDATE; ' || ' :NEW.call_stack := '
    || 'SUBSTR (dbms_utility.Format_call_stack (), 1, 4000); END;');
END /*create_error_log*/

      PROCEDURE generate_spec (package_name_in      VARCHAR(32000)
                             , code_out            DBMS_SQL.varchar2s
                              )
        RETURNS(         CODE_OUT_OUT DBMS_SQL.varchar2s)

AS
         PROCEDURE add_line (line_in  VARCHAR(32000))
         AS
BEGIN
            l_spec (l_spec.COUNT + 1) = :line_in;
END /*add_line*/
BEGIN
         EXECUTE PROCEDURE add_line ('CREATE OR REPLACE PACKAGE ' || :c_package_name || ' IS ');
         EXECUTE PROCEDURE add_line(   'SUBTYPE error_log_r IS '
                  || :c_qual_errlog_table_name
                  || '%ROWTYPE;');
         EXECUTE PROCEDURE add_line(   'TYPE error_log_tc IS TABLE OF '
                  || :c_qual_errlog_table_name
                  || '%ROWTYPE;');
         EXECUTE PROCEDURE add_line ('PROCEDURE clear_error_log;');
         EXECUTE PROCEDURE add_line ('FUNCTION error_log_contents (');
         EXECUTE PROCEDURE add_line ('  ORA_ERR_NUMBER$_IN IN PLS_INTEGER DEFAULT NULL');
         EXECUTE PROCEDURE add_line (', ORA_ERR_OPTYP$_IN IN VARCHAR2 DEFAULT NULL');
         EXECUTE PROCEDURE add_line (', ORA_ERR_TAG$_IN IN VARCHAR2 DEFAULT NULL');
         EXECUTE PROCEDURE add_line (', where_in IN VARCHAR2 DEFAULT NULL');
         EXECUTE PROCEDURE add_line (', preserve_log_in IN BOOLEAN DEFAULT TRUE');
         EXECUTE PROCEDURE add_line (') RETURN error_log_tc;');
         -- add_line ('PROCEDURE dump_error_log;');
         EXECUTE PROCEDURE add_line ('END ' || :c_package_name || ';');
         code_out = :l_spec;
        CODE_OUT_OUT = CODE_OUT;
        SUSPEND;
END /*generate_spec*/

      PROCEDURE generate_body (package_name_in      VARCHAR(32000)
                             , code_out            DBMS_SQL.varchar2s
                              )
        RETURNS(         CODE_OUT_OUT DBMS_SQL.varchar2s)

AS
         PROCEDURE add_line (line_in  VARCHAR(32000))
         AS
BEGIN
            l_body (l_body.COUNT + 1) = :line_in;
END /*add_line*/
BEGIN
         EXECUTE PROCEDURE add_line (
            'CREATE OR REPLACE PACKAGE BODY ' || :c_package_name || ' IS '
         );
         EXECUTE PROCEDURE add_line ('PROCEDURE clear_error_log');
         EXECUTE PROCEDURE add_line ('IS PRAGMA AUTONOMOUS_TRANSACTION; BEGIN ');
         EXECUTE PROCEDURE add_line ('DELETE FROM ' || :c_qual_errlog_table_name || '; COMMIT;');
         EXECUTE PROCEDURE add_line ('END clear_error_log;');
         EXECUTE PROCEDURE add_line ('FUNCTION error_log_contents (');
         EXECUTE PROCEDURE add_line ('  ORA_ERR_NUMBER$_IN IN PLS_INTEGER DEFAULT NULL');
         EXECUTE PROCEDURE add_line (', ORA_ERR_OPTYP$_IN IN VARCHAR2 DEFAULT NULL');
         EXECUTE PROCEDURE add_line (', ORA_ERR_TAG$_IN IN VARCHAR2 DEFAULT NULL');
         EXECUTE PROCEDURE add_line (', where_in IN VARCHAR2 DEFAULT NULL');
         EXECUTE PROCEDURE add_line (', preserve_log_in IN BOOLEAN DEFAULT TRUE');
         EXECUTE PROCEDURE add_line (') RETURN error_log_tc');
         EXECUTE PROCEDURE add_line (' IS ');
         EXECUTE PROCEDURE add_line('l_query      VARCHAR2 (32767)
         :=    ''SELECT * FROM '
                  || :c_qual_errlog_table_name
                  || ' WHERE ( ora_err_number$ LIKE :ora_err_number$_in
              OR :ora_err_number$_in IS NULL');
         EXECUTE PROCEDURE add_line(') AND (   ora_err_optyp$ LIKE :ora_err_optyp$_in
              OR :ora_err_optyp$_in IS NULL )');
         EXECUTE PROCEDURE add_line('AND (ora_err_tag$ LIKE :ora_err_tag$_in OR :ora_err_tag$_in IS NULL)''
            || CASE WHEN where_in IS NULL');
         EXECUTE PROCEDURE add_line('THEN NULL ELSE '' AND '' || REPLACE (where_in, '''''''', '''''''''''') END;
      l_log_rows   error_log_tc;');
         EXECUTE PROCEDURE add_line (
            'BEGIN EXECUTE IMMEDIATE l_query BULK COLLECT INTO l_log_rows'
         );
         EXECUTE PROCEDURE add_line('USING ORA_ERR_NUMBER$_IN, ORA_ERR_NUMBER$_IN,
               ORA_ERR_OPTYP$_IN, ORA_ERR_OPTYP$_IN,
               ORA_ERR_TAG$_IN, ORA_ERR_TAG$_IN; RETURN l_log_rows;');
         EXECUTE PROCEDURE add_line ('IF NOT preserve_log_in THEN clear_error_log(); END IF;');
         EXECUTE PROCEDURE add_line('EXCEPTION WHEN OTHERS THEN
         DBMS_OUTPUT.put_line (''Error retrieving log contents for :'');
         DBMS_OUTPUT.put_line (DBMS_UTILITY.format_error_stack);
         DBMS_OUTPUT.put_line (l_query);
         RAISE;');
         EXECUTE PROCEDURE add_line ('END error_log_contents; END ' || :c_package_name || ';');
         code_out = :l_body;
        CODE_OUT_OUT = CODE_OUT;
        SUSPEND;
END /*generate_body*/
BEGIN
      IN AUTONOMOUS TRANSACTION DO BEGIN
EXECUTE PROCEDURE create_error_log;
      EXECUTE PROCEDURE generate_spec (:c_package_name, :err_log_package_spec);
      EXECUTE PROCEDURE generate_body (:c_package_name, :err_log_package_body);
	END
     ERR_LOG_PACKAGE_SPEC_OUT = ERR_LOG_PACKAGE_SPEC;
     ERR_LOG_PACKAGE_BODY_OUT = ERR_LOG_PACKAGE_BODY;
     SUSPEND;
END /*create_objects*/  

   PROCEDURE create_objects (dml_table_name           VARCHAR(32000)
                           , err_log_table_name       VARCHAR(32000) DEFAULT NULL
                           , err_log_table_owner      VARCHAR(32000) DEFAULT NULL
                           , err_log_table_space      VARCHAR(32000) DEFAULT NULL
                           , skip_unsupported         BOOLEAN DEFAULT FALSE
                           , overwrite_log_table      BOOLEAN DEFAULT TRUE
                           , err_log_package_name     VARCHAR(32000) DEFAULT NULL
                           , err_log_package_spec  VARCHAR(32000)
                           , err_log_package_body  VARCHAR(32000)
                            )
     RETURNS(      ERR_LOG_PACKAGE_SPEC_OUT VARCHAR(32000), 
     ERR_LOG_PACKAGE_BODY_OUT VARCHAR(32000))

AS
      DECLARE l_spec          DBMS_SQL.varchar2s;
      DECLARE l_body          DBMS_SQL.varchar2s;
      DECLARE l_spec_string   maxvarchar2_t;
      DECLARE l_body_string   maxvarchar2_t;

  DECLARE VARIABLE indx INTEGER;
BEGIN
      EXECUTE PROCEDURE create_objects (:dml_table_name         => :dml_table_name
                    , :err_log_table_name     => :err_log_table_name
                    , :err_log_table_owner    => :err_log_table_owner
                    , :err_log_table_space    => :err_log_table_space
                    , :skip_unsupported       => :skip_unsupported
                    , :overwrite_log_table    => :overwrite_log_table
                    , :err_log_package_name   => :err_log_package_name
                    , :err_log_package_spec   => :l_spec
                    , :err_log_package_body   => :l_body
                     );

indx = 1;
WHILE ( indx  <=    l_spec.COUNT) DO
BEGIN
      
         l_spec_string =
            CASE
               WHEN :indx = 1 THEN :l_spec (:indx)
               ELSE :l_spec_string || CHR (10) || :l_spec (:indx)
END;
indx = indx + 1;
END
 

indx = 1;
WHILE ( indx  <=    l_body.COUNT) DO
BEGIN
      
         l_body_string =
            CASE
               WHEN :indx = 1 THEN :l_body (:indx)
               ELSE :l_body_string || CHR (10) || :l_body (:indx)
END;
indx = indx + 1;
END
 

      err_log_package_spec = :l_spec_string;
      err_log_package_body = :l_body_string;
     ERR_LOG_PACKAGE_SPEC_OUT = ERR_LOG_PACKAGE_SPEC;
     ERR_LOG_PACKAGE_BODY_OUT = ERR_LOG_PACKAGE_BODY;
     SUSPEND;
END /*create_objects*/  

   PROCEDURE create_objects (dml_table_name        VARCHAR(32000)
                           , err_log_table_name    VARCHAR(32000) DEFAULT NULL
                           , err_log_table_owner   VARCHAR(32000) DEFAULT NULL
                           , err_log_table_space   VARCHAR(32000) DEFAULT NULL
                           , skip_unsupported      BOOLEAN DEFAULT FALSE
                           , overwrite_log_table   BOOLEAN DEFAULT TRUE
                           , err_log_package_name  VARCHAR(32000) DEFAULT NULL
                            )
AS
      
      DECLARE l_spec   DBMS_SQL.varchar2s;
      DECLARE l_body   DBMS_SQL.varchar2s;

      PROCEDURE compile_statement (array_in  DBMS_SQL.varchar2s)
AS
         DECLARE l_cur   PLS_INTEGER = DBMS_SQL.open_cursor;
BEGIN
         DBMS_SQL.parse (:l_cur
                       , :array_in
                       , 1
                       , array_in.COUNT
                       , TRUE
                       , DBMS_SQL.native
                        );
         DBMS_SQL.close_cursor (:l_cur);
END /*compile_statement*/
BEGIN
      IN AUTONOMOUS TRANSACTION DO BEGIN
EXECUTE PROCEDURE create_objects (:dml_table_name         => :dml_table_name
                    , :err_log_table_name     => :err_log_table_name
                    , :err_log_table_owner    => :err_log_table_owner
                    , :err_log_table_space    => :err_log_table_space
                    , :skip_unsupported       => :skip_unsupported
                    , :overwrite_log_table    => :overwrite_log_table
                    , :err_log_package_name   => :err_log_package_name
                    , err_log_package_spec   => :l_spec
                    , err_log_package_body   => :l_body
                     );
      EXECUTE PROCEDURE compile_statement (:l_spec);
      EXECUTE PROCEDURE compile_statement (:l_body);
	END
/*EXCEPTION*/
      WHEN OTHERS DO BEGIN
	 dbms_output.put_line (dbms_utility.format_error_backtrace); raise;
 END
END /*create_objects*/  
  END ;

SET TERM ; ^


CREATE OR ALTER PACKAGE 
AS BEGIN 
    DECLARE NEXT_GET_PAR_URL          VARCHAR(1024);  
    DECLARE COLLECTION_INDEX_POSITION NUMERIC(18, 4);  
    DECLARE ITEMS                     JSON_ARRAY_T;  
    DECLARE ITEMS_SIZE                NUMERIC(18, 4);  
    DECLARE TOTAL_RECORDS             NUMERIC(18, 4);  

    PROCEDURE SET_PAR_URL(PAR_URL  VARCHAR(32000));  
    FUNCTION GET_NEXT_ITEM RETURNS BLOB SUB_TYPE TEXT;  
  END;



SET TERM ^ ;

RECREATE   PACKAGE BODY 
AS BEGIN 
    PROCEDURE SET_PAR_URL(PAR_URL  VARCHAR(32000))
    AS
BEGIN
        ADBS_PAR_URL_CLIENT.NEXT_GET_PAR_URL = :PAR_URL;
        ADBS_PAR_URL_CLIENT.COLLECTION_INDEX_POSITION = 0;
        ADBS_PAR_URL_CLIENT.ITEMS = JSON_ARRAY_T('[]');
        ADBS_PAR_URL_CLIENT.ITEMS_SIZE = 0;
        ADBS_PAR_URL_CLIENT.TOTAL_RECORDS = 0;
END  

    FUNCTION GET_NEXT_ITEM
        RETURNS BLOB SUB_TYPE TEXT
    AS
        DECLARE HTTP_REQUEST  UTL_HTTP.REQ;
        DECLARE HTTP_RESPONSE UTL_HTTP.RESP;
        DECLARE RESPONSE_CODE NUMERIC(18, 4);
        DECLARE RESPONSE_CONTENT  BLOB SUB_TYPE TEXT;
        DECLARE TEMP_BUFFER   VARCHAR(32767);
        DECLARE LINKS JSON_ARRAY_T;
        DECLARE HAS_MORE VARCHAR(32767);
        DECLARE JSON_OBJ JSON_OBJECT_T;

  DECLARE VARIABLE itemsIndx INTEGER;

  DECLARE VARIABLE linksIndx INTEGER;
BEGIN

       IF (ADBS_PAR_URL_CLIENT.COLLECTION_INDEX_POSITION < ADBS_PAR_URL_CLIENT.ITEMS_SIZE) THEN
       BEGIN
            ADBS_PAR_URL_CLIENT.COLLECTION_INDEX_POSITION = ADBS_PAR_URL_CLIENT.COLLECTION_INDEX_POSITION + 1;
RETURN ADBS_PAR_URL_CLIENT.ITEMS.GET(ADBS_PAR_URL_CLIENT.COLLECTION_INDEX_POSITION - 1).to_Clob;
       END
ELSE
            IF (ADBS_PAR_URL_CLIENT.NEXT_GET_PAR_URL IS NOT NULL) THEN
            BEGIN

                -- Iterate and remove each item from the global array
                itemsIndx = 0;
                WHILE ( itemsIndx  <=    ADBS_PAR_URL_CLIENT.ITEMS.get_size - 1) DO
                BEGIN
                
                    ADBS_PAR_URL_CLIENT.ITEMS.REMOVE(:itemsIndx);
                itemsIndx = itemsIndx + 1;
                END
 

                -- Initialize the CLOB.
                DBMS_LOB.CREATETEMPORARY(:RESPONSE_CONTENT, false);

                HTTP_REQUEST = UTL_HTTP.BEGIN_REQUEST(ADBS_PAR_URL_CLIENT.NEXT_GET_PAR_URL, 'GET');
                UTL_HTTP.SET_HEADER(:HTTP_REQUEST, 'CONTENT-TYPE', 'application/json');

                DBMS_OUTPUT.PUT_LINE('Invoking Get Request On Url: ' || ADBS_PAR_URL_CLIENT.NEXT_GET_PAR_URL);

                -- Get response.
                HTTP_RESPONSE = UTL_HTTP.GET_RESPONSE(:HTTP_REQUEST);

                -- Status code
                RESPONSE_CODE = HTTP_RESPONSE.STATUS_CODE;
                DBMS_OUTPUT.PUT_LINE('Response received. STATUS=' || :RESPONSE_CODE);
                DBMS_OUTPUT.PUT_LINE('Response received. REASON_PHRASE=' || HTTP_RESPONSE.reason_phrase);
                DBMS_OUTPUT.PUT_LINE('Response received. HTTP_VERSION=' || HTTP_RESPONSE.http_version);

                IF (HTTP_RESPONSE.STATUS_CODE = 200) THEN
                BEGIN
BEGIN
                        -- Copy the response into the intermediate CLOB.
                        WHILE (TRUE) DO BEGIN
UTL_HTTP.READ_TEXT(:HTTP_RESPONSE, :TEMP_BUFFER, 32766);
                            RESPONSE_CONTENT = :RESPONSE_CONTENT || :TEMP_BUFFER;
END 

                        UTL_HTTP.END_RESPONSE(:HTTP_RESPONSE);

/*EXCEPTION*/
                        WHEN UTL_HTTP.END_OF_BODY DO
                            BEGIN
	                            UTL_HTTP.END_RESPONSE(:HTTP_RESPONSE);
                            END

WHEN OTHERS DO
                            BEGIN
	                            DBMS_OUTPUT.PUT_LINE(SQLERRM);
                            DBMS_OUTPUT.PUT_LINE(DBMS_UTILITY.FORMAT_ERROR_BACKTRACE);
                            UTL_HTTP.END_RESPONSE(:HTTP_RESPONSE);
                            END
END

                    JSON_OBJ = JSON_OBJECT_T( :RESPONSE_CONTENT );
                    ADBS_PAR_URL_CLIENT.ITEMS = JSON_OBJ.GET_ARRAY('items');
                    DBMS_OUTPUT.PUT_LINE('size:' || ADBS_PAR_URL_CLIENT.ITEMS.get_size);
                    ADBS_PAR_URL_CLIENT.TOTAL_RECORDS = ADBS_PAR_URL_CLIENT.TOTAL_RECORDS + ADBS_PAR_URL_CLIENT.ITEMS.get_size;
                    ADBS_PAR_URL_CLIENT.COLLECTION_INDEX_POSITION = 0;
                    ADBS_PAR_URL_CLIENT.ITEMS_SIZE = ADBS_PAR_URL_CLIENT.ITEMS.get_size;

                    -- Get the links field from the json response
                    LINKS = JSON_OBJ.GET_ARRAY('links');

                    -- Iterate and get the next page href if available
linksIndx = 0;
WHILE ( linksIndx  <=    LINKS.get_size - 1) DO
BEGIN
                    
                        IF (JSON_OBJECT_T( LINKS.get(:linksIndx)).GET_STRING('rel') = 'next') THEN
                        BEGIN
                            ADBS_PAR_URL_CLIENT.NEXT_GET_PAR_URL = JSON_OBJECT_T(LINKS.get(:linksIndx)).GET_STRING('href');
                            DBMS_OUTPUT.PUT_LINE('next href: ' || ADBS_PAR_URL_CLIENT.NEXT_GET_PAR_URL);
                        END
 
linksIndx = linksIndx + 1;
END
 

                    -- Get the hasMore field from the json response
                    HAS_MORE = JSON_OBJ.GET_STRING('hasMore');
                    DBMS_OUTPUT.PUT_LINE('hasMore: ' || :HAS_MORE);

                    IF (:HAS_MORE = 'false') THEN
                        ADBS_PAR_URL_CLIENT.NEXT_GET_PAR_URL = NULL;
 

                    -- Relase the resources associated with the temporary LOB.
                    DBMS_LOB.FREETEMPORARY(:RESPONSE_CONTENT);
                    ADBS_PAR_URL_CLIENT.COLLECTION_INDEX_POSITION = COLLECTION_INDEX_POSITION + 1;
RETURN ADBS_PAR_URL_CLIENT.ITEMS.GET(ADBS_PAR_URL_CLIENT.COLLECTION_INDEX_POSITION - 1).to_Clob;
                END
ELSE
BEGIN
                    ADBS_PAR_URL_CLIENT.NEXT_GET_PAR_URL = NULL;
                    DBMS_OUTPUT.PUT_LINE('ERROR');
                    UTL_HTTP.END_RESPONSE(:HTTP_RESPONSE);
RETURN NULL;
END
 
            END
ELSE
                RETURN NULL;
 
 
END  
  END;

SET TERM ; ^



CREATE OR ALTER PACKAGE plscope_demo
AS BEGIN 
   PROCEDURE my_procedure (param1_in  INTEGER
                         , param2     TYPE OF COLUMN employees.last_name
                          );  
  END ;



SET TERM ^ ;

RECREATE   PACKAGE BODY plscope_demo
AS BEGIN
/*
Error at line 10:6 - no viable alternative at input 'l_local_variable                -- MY ERROR -> missed "IF"\n      THEN'
 
   PROCEDURE my_procedure (param1_in IN INTEGER
                         , param2    IN employees.last_name%TYPE
                          )
   IS
      c_no_such   CONSTANT  NUMBER := 100;
      l_local_variable     NUMBER;
BEGIN
        param1_in > l_local_variable                -- MY ERROR -> missed "IF"
      THEN
         DBMS_OUTPUT.put_line (param2);
ELSE
         DBMS_OUTPUT.put_line (c_no_such);
END IF;
END my_procedure; 
*/ 
  END ;

SET TERM ; ^



CREATE OR ALTER PACKAGE plscope_demo
AS BEGIN 
   DECLARE public_global NUMERIC(18, 4);  

   PROCEDURE my_procedure (param1_in  INTEGER, param2  DATE); 
/*
Error at line 4:39 - no viable alternative at input 'FUNCTION my_function (param1    IN INTEGER\n                       , in_param2 INS DATE'
 

   FUNCTION my_function (param1    IN INTEGER
                       , in_param2 INS DATE                  -- MY ERROR -> should be "IN"
                       , param3_in IN employees.last_name%TYPE
                        )
      RETURN VARCHAR2; 
*/ 
  END ;



CREATE OR ALTER PACKAGE  AUTHID DEFINER
AS BEGIN 
   DECLARE TYPE record_t  
      (nm VARCHAR (100), sal NUMERIC(18, 4));  

   /*TYPE array_t IS TABLE OF record_t INDEX BY PLS_INTEGER;*/  

   FUNCTION my_array RETURNS array_t;  
  END;



SET TERM ^ ;

RECREATE   PACKAGE BODY 
AS BEGIN
/*
Error at line 7:9 - mismatched input '(' expecting ';'
 
   FUNCTION my_array
      RETURN array_t
   IS
      l_return   array_t;
BEG                                                   -- MY ERROR -> should be BEGIN
l_return (1).nm := 'Me';
      l_return (1).sal := 1000;
      l_return (200).nm := 'You';
      l_return (200).sal := 2;

RETURN l_return;
 
*/ END;

SET TERM ; ^
/*
Error at line 2:0 - no viable alternative at input 'END'

END;
*/



CREATE OR ALTER PACKAGE  AUTHID DEFINER
AS BEGIN 
   DECLARE TYPE record_t  
   (
      idx   INTEGER,
      nm    VARCHAR (100),
      sal   NUMERIC(18, 4)
   );  

   /*TYPE array_t IS TABLE OF record_t INDEX BY PLS_INTEGER;*/  

   FUNCTION my_array RETURNS array_t;  
  END;



SET TERM ^ ;

RECREATE   PACKAGE BODY 
AS BEGIN
/*
Error at line 2:21 - no viable alternative at input 'FUNCTION my_array RURN'
 
   FUNCTION my_array RURN array_t               -- MY ERROR -> should be "RETURN"
   IS
      l_return   array_t;
BEGIN
      l_return (1).nm := 'Me';
      l_return (1).sal := 1000;
      l_return (-200).nm := 'You';
      l_return (-200).sal := 2;

RETURN l_return;
END; 
*/ 
  END;

SET TERM ; ^



CREATE OR ALTER PACKAGE multdim AUTHID DEFINER
AS BEGIN
/*
Error at line 3:35 - mismatched input '(' expecting ';'
 

   TYPE dim1_t IS TABLE OF VARCHR2 (32767) INDEX BY PLS_INTEGER; 
*/    -- MY ERROR -> should be "VARCHAR2"

   /*TYPE dim2_t IS TABLE OF dim1_t INDEX BY PLS_INTEGER;*/  

   /*TYPE dim3_t IS TABLE OF dim2_t INDEX BY PLS_INTEGER;*/  

   PROCEDURE setcell (
      array_in       dim3_t
     ,dim1_in             PLS_INTEGER
     ,dim2_in             PLS_INTEGER
     ,dim3_in             PLS_INTEGER
     ,value_in          VARCHAR(32000)
   );  

   FUNCTION getcell (
      array_in      dim3_t
     ,dim1_in         PLS_INTEGER
     ,dim2_in         PLS_INTEGER
     ,dim3_in         PLS_INTEGER
   )
      RETURNS VARCHAR(32000);  

   FUNCTION EXISTS (
      array_in      dim3_t
     ,dim1_in         PLS_INTEGER
     ,dim2_in         PLS_INTEGER
     ,dim3_in         PLS_INTEGER
   )
      RETURNS BOOLEAN;  
  END ;



SET TERM ^ ;

RECREATE   PACKAGE BODY multdim
AS BEGIN
/*
Error at line 12:25 - mismatched input '(' expecting {<EOF>, ';'}
 
   PROCEDURE setcell (
      array_in   IN OUT   dim3_t
     ,dim1_in             PLS_INTEGER
     ,dim2_in             PLS_INTEGER
     ,dim3_in             PLS_INTEGER
     ,value_in   IN       VARCHAR2
   )
   IS
BEGIN

      array_in (dim3_in) (dim2_in) (dim1_in) := value_in;

END; 
*/
/*
Error at line 4:6 - no viable alternative at input 'FUNCTION getcell                                                -- MY ERROR -> missed "("\n      array_in'
 

   FUNCTION getcell                                                -- MY ERROR -> missed "("
      array_in   IN   dim3_t
     ,dim1_in         PLS_INTEGER
     ,dim2_in         PLS_INTEGER
     ,dim3_in         PLS_INTEGER
   )
      RETURN VARCHAR2
   IS
BEGIN
RETURN array_in (dim3_in) (dim2_in) (dim1_in);
END; 
*/
/*
Error at line 13:36 - mismatched input '(' expecting {<EOF>, ';'}
 

   FUNCTION EXISTS (
      array_in   IN   dim3_t
     ,dim1_in         PLS_INTEGER
     ,dim2_in         PLS_INTEGER
     ,dim3_in         PLS_INTEGER
   )
      RETURN BOOLEAN
   IS
      l_value   VARCHAR2 (32767);
BEGIN
      l_value := array_in (dim3_in) (dim2_in) (dim1_in);
RETURN TRUE;
EXCEPTION
      WHEN NO_DATA_FOUND OR VALUE_ERROR
      THEN
         RETURN FALSE;
END; 
*/ 
  END ;

SET TERM ; ^



CREATE OR ALTER PACKAGE 
AS BEGIN 
   DECLARE steven_authors   strings_nt;  
   DECLARE veva_authors     strings_nt;  
   DECLARE eli_authors      strings_nt;  

   PROCEDURE show_authors (title_in  VARCHAR(32000), authors_in  strings_nt);  

   PROCEDURE init_authors;  
  END;



SET TERM ^ ;

RECREATE   PACKAGE BODY 
AS BEGIN
/*
Error at line 7:11 - mismatched input '..' expecting '.'
 
   PROCEDURE show_authors (title_in IN VARCHAR2, authors_in IN strings_nt)
   IS
BEGIN
      DBMS_OUTPUT.put_line (title_in);

 indx IN 1 .. authors_in.COUNT                                              -- MY ERROR -> missed "FOR"
      LOOP
         DBMS_OUTPUT.put_line (indx || ' = ' || authors_in (indx));
END LOOP;
END show_authors; 
*/ 

   PROCEDURE init_authors
AS
BEGIN
      steven_authors =
         strings_nt ('ROBIN HOBB'
                   , 'ROBERT HARRIS'
                   , 'DAVID BRIN'
                   , 'SHERI S. TEPPER'
                   , 'CHRISTOPHER ALEXANDER'
                   , 'PIERS ANTHONY');
      veva_authors =
         strings_nt ('ROBIN HOBB', 'SHERI S. TEPPER', 'ANNE MCCAFFREY');

      eli_authors =
         strings_nt ('PIERS ANTHONY', 'SHERI S. TEPPER', 'DAVID BRIN');
END  
  END;

SET TERM ; ^



CREATE OR ALTER PACKAGE assert
AS BEGIN 
   PROCEDURE assert (
      condition_in  BOOLEAN
    , msg_in  VARCHAR(32000)
    , display_call_stack_in  BOOLEAN DEFAULT FALSE
    , null_means_failure_in  BOOLEAN DEFAULT TRUE
   );  

   PROCEDURE is_null (
      val_in  VARCHAR(32000)
    , msg_in  VARCHAR(32000)
    , display_call_stack_in  BOOLEAN DEFAULT FLSE             -- MY ERROR -> should be "FALSE"
   );  

   PROCEDURE is_not_null (
      val_in  VARCHAR(32000)
    , msg_in  VARCHAR(32000)
    , display_call_stack_in  BOOLEAN DEFAULT FALSE
   );  

   PROCEDURE is_true (
      condition_in  BOOLEAN
    , msg_in  VARCHAR(32000)
    , display_call_stack_in  BOOLEAN DEFAULT FALSE
   );  
  END ;



SET TERM ^ ;

RECREATE   PACKAGE BODY assert
AS BEGIN
/*
Error at line 12:6 - mismatched input 'THEN' expecting '.'
 
   PROCEDURE assert (
      condition_in IN BOOLEAN
    , msg_in IN VARCHAR2
    , display_call_stack_in IN BOOLEAN DEFAULT FALSE
    , null_means_failure_in IN BOOLEAN DEFAULT TRUE
   )
   IS
BEGIN
NOT condition_in                                         -- MY ERROR -> missed "IF"
         OR (null_means_failure_in AND condition_in IS NULL)
      THEN
         DBMS_OUTPUT.put_line ('ASSERTION VIOLATION! ' || msg_in);

         raise_application_error (-20000, 'ASSERTION VIOLATION! ' || msg_in);
END IF;
END; 
*/ 

   PROCEDURE is_null (
      val_in  VARCHAR(32000)
    , msg_in  VARCHAR(32000)
    , display_call_stack_in  BOOLEAN DEFAULT FALSE
   )
AS
BEGIN
      assert (:val_in IS NULL
               , :msg_in
               , :display_call_stack_in
               , null_means_failure_in      => FALSE
                );
END /*is_null*/  

   PROCEDURE is_not_null (
      val_in  VARCHAR(32000)
    , msg_in  VARCHAR(32000)
    , display_call_stack_in  BOOLEAN DEFAULT FALSE
   )
AS
BEGIN
      assert (:val_in IS NOT NULL, :msg_in, :display_call_stack_in);
END /*is_not_null*/  

   PROCEDURE is_true (
      condition_in  BOOLEAN
    , msg_in  VARCHAR(32000)
    , display_call_stack_in  BOOLEAN DEFAULT FALSE
   )
AS
BEGIN
      assert (:condition_in, :msg_in, :display_call_stack_in);
END /*is_true*/  
  END ;

SET TERM ; ^



CREATE OR ALTER PACKAGE 
AS BEGIN 
   failure_in_forall   EXCEPTION;  

     

   PROCEDURE log_error (app_info_in  VARCHAR(32000));  
  END;



SET TERM ^ ;

RECREATE   PACKAGE BODY 
AS BEGIN
/*
Error at line 14:4 - no viable alternative at input 'VALS'
 
   PROCEDURE log_error (app_info_in IN VARCHAR2)
   IS
      PRAGMA AUTONOMOUS_TRANSACTION;
      c_code   CONSTANT INTEGER := SQLCODE;
BEGIN
INSERT INTO error_log (created_on,
                       created_by,
                       errorcode,
                       callstack,
                       errorstack,
                       backtrace,
                       error_info)
    VALS (SYSTIMESTAMP,                                         -- MY ERROR -> should be "VALUES"
        USER,
        c_code,
        DBMS_UTILITY.format_call_stack,
        DBMS_UTILITY.format_error_stack,
        DBMS_UTILITY.format_error_backtrace,
        app_info_in);

COMMIT;
END; 
*/ 
  END;

SET TERM ; ^



CREATE OR ALTER PACKAGE 
   AUTHID DEFINER
AS BEGIN
/*
Error at line 2:31 - no viable alternative at input 'FUNCTION format_call_stack  VARCHAR2'
 
   FUNCTION format_call_stack  VARCHAR2; 
*/               -- MY ERROR -> missed "RETURN"
   FUNCTION format_error_stack RETURNS VARCHAR(32000);  
   FUNCTION format_error_backtrace RETURNS VARCHAR(32000);  
   FUNCTION backtrace_to RETURNS VARCHAR(32000);  
  END;



SET TERM ^ ;

RECREATE   PACKAGE BODY 
AS BEGIN
/*
Error at line 3:7 - no viable alternative at input 'FUNCTION format_call_stack\n       VARCHAR2'
 
   FUNCTION format_call_stack
       VARCHAR2                                                        -- MY ERROR -> missed "RETURN"
   IS
      l_return   VARCHAR2 (32767)
         :=    '----- PL/SQL Call Stack -------'
            || CHR (10)
            || 'Line     Object name'
            || CHR (10)
            || '-------- ----------------------';
BEGIN
       1 is always this function, so ignore it. 
FOR indx IN 2 .. utl_call_stack.dynamic_depth
      LOOP
         l_return :=
               l_return
            || case when l_return is not null then CHR (10) end
            || LPAD (TO_CHAR (utl_call_stack.unit_line (indx)), 8)
            || ' '
            || utl_call_stack.owner (indx)
            || '.'
            || utl_call_stack.concatenate_subprogram (
                  utl_call_stack.subprogram (indx));
END LOOP;

RETURN l_return;
END; 
*/ 

   FUNCTION format_error_stack
      RETURNS VARCHAR(32000)
   AS
      DECLARE l_return   VARCHAR (32767);

  DECLARE VARIABLE indx INTEGER;
BEGIN
indx = 1;
WHILE ( indx  <=    utl_call_stack.error_depth) DO
BEGIN
      
         l_return =
               :l_return
            || case when :l_return is not null then CHR (10) end
            || 'ORA-'
            || LPAD (CAST (utl_call_stack.error_number (:indx) AS VARCHAR(32000)), 5, '0')
            || ': '
            || utl_call_stack.error_msg (:indx);
indx = indx + 1;
END
 

RETURN l_return;
END  

   FUNCTION format_error_backtrace
      RETURNS VARCHAR(32000)
   AS
      DECLARE l_return   VARCHAR (32767);

  DECLARE VARIABLE indx INTEGER;
BEGIN
indx = 1;
WHILE ( indx  <=    utl_call_stack.backtrace_depth) DO
BEGIN
      
         l_return =
               :l_return
            || case when :l_return is not null then CHR (10) end
            || :indx
            || ' -> '
            || utl_call_stack.backtrace_unit (:indx)
            || ' - Line '
            || CAST (utl_call_stack.backtrace_line (:indx) AS VARCHAR(32000));
indx = indx + 1;
END
 

RETURN l_return;
/*EXCEPTION*/
      WHEN OTHERS
      DO
         BEGIN
	         IF (SQLCODE = -64610)
         THEN
            /* ORA-64610: bad depth indicator */
            RETURN l_return;
ELSE
            RAISE;
 
         END
END  

   FUNCTION backtrace_to
      RETURNS VARCHAR(32000)
   AS
BEGIN
RETURN    utl_call_stack.backtrace_unit (1)
    || ' on line '
    || utl_call_stack.backtrace_line (1);
END  
  END;

SET TERM ; ^

