CREATE OR REPLACE PACKAGE my_utl_call_stack
   AUTHID DEFINER
IS
   FUNCTION format_call_stack RETURN VARCHAR2;
   FUNCTION format_error_stack RETURN VARCHAR2;
   FUNCTION format_error_backtrace RETURN VARCHAR2;
   FUNCTION backtrace_to RETURN VARCHAR2;
END;
/
CREATE OR REPLACE PACKAGE pkg
   AUTHID DEFINER
IS
   PROCEDURE p;
END;
/

CREATE OR REPLACE PACKAGE BODY pkg
IS
   PROCEDURE p
   IS
BEGIN
      p1;
END;
END;
/

CREATE OR REPLACE PACKAGE dbms_errlog_helper
   AUTHID CURRENT_USER
IS
   PROCEDURE create_objects (dml_table_name           VARCHAR2
                           , err_log_table_name       VARCHAR2 DEFAULT NULL
                           , err_log_table_owner      VARCHAR2 DEFAULT NULL
                           , err_log_table_space      VARCHAR2 DEFAULT NULL
                           , skip_unsupported         BOOLEAN DEFAULT FALSE
                           , overwrite_log_table      BOOLEAN DEFAULT TRUE
                           , err_log_package_name     VARCHAR2 DEFAULT NULL
                           , err_log_package_spec OUT DBMS_SQL.varchar2s
                           , err_log_package_body OUT DBMS_SQL.varchar2s
                            );

   PROCEDURE create_objects (dml_table_name           VARCHAR2
                           , err_log_table_name       VARCHAR2 DEFAULT NULL
                           , err_log_table_owner      VARCHAR2 DEFAULT NULL
                           , err_log_table_space      VARCHAR2 DEFAULT NULL
                           , skip_unsupported         BOOLEAN DEFAULT FALSE
                           , overwrite_log_table      BOOLEAN DEFAULT TRUE
                           , err_log_package_name     VARCHAR2 DEFAULT NULL
                           , err_log_package_spec OUT VARCHAR2
                           , err_log_package_body OUT VARCHAR2
                            );

   PROCEDURE create_objects (dml_table_name        VARCHAR2
                           , err_log_table_name    VARCHAR2 DEFAULT NULL
                           , err_log_table_owner   VARCHAR2 DEFAULT NULL
                           , err_log_table_space   VARCHAR2 DEFAULT NULL
                           , skip_unsupported      BOOLEAN DEFAULT FALSE
                           , overwrite_log_table   BOOLEAN DEFAULT TRUE
                           , err_log_package_name  VARCHAR2 DEFAULT NULL
                            );
END dbms_errlog_helper;
/

CREATE OR REPLACE PACKAGE BODY dbms_errlog_helper
IS
   SUBTYPE maxvarchar2_t IS VARCHAR2 (32767);

   PROCEDURE create_objects (dml_table_name           VARCHAR2
                           , err_log_table_name       VARCHAR2 DEFAULT NULL
                           , err_log_table_owner      VARCHAR2 DEFAULT NULL
                           , err_log_table_space      VARCHAR2 DEFAULT NULL
                           , skip_unsupported         BOOLEAN DEFAULT FALSE
                           , overwrite_log_table      BOOLEAN DEFAULT TRUE
                           , err_log_package_name     VARCHAR2 DEFAULT NULL
                           , err_log_package_spec OUT DBMS_SQL.varchar2s
                           , err_log_package_body OUT DBMS_SQL.varchar2s
                            )
IS
      PRAGMA AUTONOMOUS_TRANSACTION;
      c_package_name CONSTANT maxvarchar2_t
            := SUBSTR (NVL (err_log_package_name, 'ELP$_' || dml_table_name)
                     , 1
                     , 30
                      ) ;
      c_errlog_table_name CONSTANT maxvarchar2_t
            := SUBSTR (NVL (err_log_table_name, 'ERR$_' || dml_table_name)
                     , 1
                     , 30
                      ) ;
      c_qual_errlog_table_name CONSTANT maxvarchar2_t
            := CASE
                  WHEN err_log_table_owner IS NULL THEN NULL
                  ELSE err_log_table_owner || '.'
END
|| c_errlog_table_name ;
      l_spec   DBMS_SQL.varchar2s;
      l_body   DBMS_SQL.varchar2s;

      PROCEDURE create_error_log
IS
BEGIN
         IF overwrite_log_table
         THEN
BEGIN
EXECUTE IMMEDIATE 'DROP TABLE ' || c_qual_errlog_table_name;
EXCEPTION
               WHEN OTHERS
               THEN
                  NULL;
END;
END IF;
         DBMS_ERRLOG.create_error_log (
            dml_table_name        => dml_table_name
          , err_log_table_name    => err_log_table_name
          , err_log_table_owner   => err_log_table_owner
          , err_log_table_space   => err_log_table_space
          , skip_unsupported      => skip_unsupported
         );

         /* Alter the error log table to add audit columns. */
EXECUTE IMMEDIATE 'ALTER TABLE ' || NVL (err_log_table_owner, USER)
    || '.' || c_errlog_table_name || ' ADD created_by VARCHAR2(30)';

EXECUTE IMMEDIATE 'ALTER TABLE ' || NVL (err_log_table_owner, USER)
    || '.' || c_errlog_table_name || ' ADD created_on DATE';

/* Add Call Stack: Thanks, IFMC! */
EXECUTE IMMEDIATE 'ALTER TABLE ' || NVL (err_log_table_owner, USER)
    || '.' || c_errlog_table_name || ' ADD call_stack VARCHAR2(4000)';

/* Add the trigger to update these columns. */
EXECUTE IMMEDIATE 'CREATE OR REPLACE TRIGGER '
    || SUBSTR (dml_table_name || '$BEF_EL', 1, 30)
    || ' BEFORE INSERT OR UPDATE ON ' || NVL (err_log_table_owner, USER)
    || '.' || c_errlog_table_name || ' FOR EACH ROW BEGIN :NEW.created_by := USER; '
    || ' :NEW.created_on := SYSDATE; ' || ' :NEW.call_stack := '
    || 'SUBSTR (dbms_utility.Format_call_stack (), 1, 4000); END;';
END create_error_log;

      PROCEDURE generate_spec (package_name_in IN     VARCHAR2
                             , code_out           OUT DBMS_SQL.varchar2s
                              )
IS
         PROCEDURE add_line (line_in IN VARCHAR2)
         IS
BEGIN
            l_spec (l_spec.COUNT + 1) := line_in;
END add_line;
BEGIN
         add_line ('CREATE OR REPLACE PACKAGE ' || c_package_name || ' IS ');
         add_line(   'SUBTYPE error_log_r IS '
                  || c_qual_errlog_table_name
                  || '%ROWTYPE;');
         add_line(   'TYPE error_log_tc IS TABLE OF '
                  || c_qual_errlog_table_name
                  || '%ROWTYPE;');
         add_line ('PROCEDURE clear_error_log;');
         add_line ('FUNCTION error_log_contents (');
         add_line ('  ORA_ERR_NUMBER$_IN IN PLS_INTEGER DEFAULT NULL');
         add_line (', ORA_ERR_OPTYP$_IN IN VARCHAR2 DEFAULT NULL');
         add_line (', ORA_ERR_TAG$_IN IN VARCHAR2 DEFAULT NULL');
         add_line (', where_in IN VARCHAR2 DEFAULT NULL');
         add_line (', preserve_log_in IN BOOLEAN DEFAULT TRUE');
         add_line (') RETURN error_log_tc;');
         -- add_line ('PROCEDURE dump_error_log;');
         add_line ('END ' || c_package_name || ';');
         code_out := l_spec;
END generate_spec;

      PROCEDURE generate_body (package_name_in IN     VARCHAR2
                             , code_out           OUT DBMS_SQL.varchar2s
                              )
IS
         PROCEDURE add_line (line_in IN VARCHAR2)
         IS
BEGIN
            l_body (l_body.COUNT + 1) := line_in;
END add_line;
BEGIN
         add_line (
            'CREATE OR REPLACE PACKAGE BODY ' || c_package_name || ' IS '
         );
         add_line ('PROCEDURE clear_error_log');
         add_line ('IS PRAGMA AUTONOMOUS_TRANSACTION; BEGIN ');
         add_line ('DELETE FROM ' || c_qual_errlog_table_name || '; COMMIT;');
         add_line ('END clear_error_log;');
         add_line ('FUNCTION error_log_contents (');
         add_line ('  ORA_ERR_NUMBER$_IN IN PLS_INTEGER DEFAULT NULL');
         add_line (', ORA_ERR_OPTYP$_IN IN VARCHAR2 DEFAULT NULL');
         add_line (', ORA_ERR_TAG$_IN IN VARCHAR2 DEFAULT NULL');
         add_line (', where_in IN VARCHAR2 DEFAULT NULL');
         add_line (', preserve_log_in IN BOOLEAN DEFAULT TRUE');
         add_line (') RETURN error_log_tc');
         add_line (' IS ');
         add_line('l_query      VARCHAR2 (32767)
         :=    ''SELECT * FROM '
                  || c_qual_errlog_table_name
                  || ' WHERE ( ora_err_number$ LIKE :ora_err_number$_in
              OR :ora_err_number$_in IS NULL');
         add_line(') AND (   ora_err_optyp$ LIKE :ora_err_optyp$_in
              OR :ora_err_optyp$_in IS NULL )');
         add_line('AND (ora_err_tag$ LIKE :ora_err_tag$_in OR :ora_err_tag$_in IS NULL)''
            || CASE WHEN where_in IS NULL');
         add_line('THEN NULL ELSE '' AND '' || REPLACE (where_in, '''''''', '''''''''''') END;
      l_log_rows   error_log_tc;');
         add_line (
            'BEGIN EXECUTE IMMEDIATE l_query BULK COLLECT INTO l_log_rows'
         );
         add_line('USING ORA_ERR_NUMBER$_IN, ORA_ERR_NUMBER$_IN,
               ORA_ERR_OPTYP$_IN, ORA_ERR_OPTYP$_IN,
               ORA_ERR_TAG$_IN, ORA_ERR_TAG$_IN; RETURN l_log_rows;');
         add_line ('IF NOT preserve_log_in THEN clear_error_log(); END IF;');
         add_line('EXCEPTION WHEN OTHERS THEN
         DBMS_OUTPUT.put_line (''Error retrieving log contents for :'');
         DBMS_OUTPUT.put_line (DBMS_UTILITY.format_error_stack);
         DBMS_OUTPUT.put_line (l_query);
         RAISE;');
         add_line ('END error_log_contents; END ' || c_package_name || ';');
         code_out := l_body;
END generate_body;
BEGIN
      create_error_log;
      generate_spec (c_package_name, err_log_package_spec);
      generate_body (c_package_name, err_log_package_body);
END create_objects;

   PROCEDURE create_objects (dml_table_name           VARCHAR2
                           , err_log_table_name       VARCHAR2 DEFAULT NULL
                           , err_log_table_owner      VARCHAR2 DEFAULT NULL
                           , err_log_table_space      VARCHAR2 DEFAULT NULL
                           , skip_unsupported         BOOLEAN DEFAULT FALSE
                           , overwrite_log_table      BOOLEAN DEFAULT TRUE
                           , err_log_package_name     VARCHAR2 DEFAULT NULL
                           , err_log_package_spec OUT VARCHAR2
                           , err_log_package_body OUT VARCHAR2
                            )
IS
      l_spec          DBMS_SQL.varchar2s;
      l_body          DBMS_SQL.varchar2s;
      l_spec_string   maxvarchar2_t;
      l_body_string   maxvarchar2_t;
BEGIN
      create_objects (dml_table_name         => dml_table_name
                    , err_log_table_name     => err_log_table_name
                    , err_log_table_owner    => err_log_table_owner
                    , err_log_table_space    => err_log_table_space
                    , skip_unsupported       => skip_unsupported
                    , overwrite_log_table    => overwrite_log_table
                    , err_log_package_name   => err_log_package_name
                    , err_log_package_spec   => l_spec
                    , err_log_package_body   => l_body
                     );

FOR indx IN 1 .. l_spec.COUNT
      LOOP
         l_spec_string :=
            CASE
               WHEN indx = 1 THEN l_spec (indx)
               ELSE l_spec_string || CHR (10) || l_spec (indx)
END;
END LOOP;

FOR indx IN 1 .. l_body.COUNT
      LOOP
         l_body_string :=
            CASE
               WHEN indx = 1 THEN l_body (indx)
               ELSE l_body_string || CHR (10) || l_body (indx)
END;
END LOOP;

      err_log_package_spec := l_spec_string;
      err_log_package_body := l_body_string;
END create_objects;

   PROCEDURE create_objects (dml_table_name        VARCHAR2
                           , err_log_table_name    VARCHAR2 DEFAULT NULL
                           , err_log_table_owner   VARCHAR2 DEFAULT NULL
                           , err_log_table_space   VARCHAR2 DEFAULT NULL
                           , skip_unsupported      BOOLEAN DEFAULT FALSE
                           , overwrite_log_table   BOOLEAN DEFAULT TRUE
                           , err_log_package_name  VARCHAR2 DEFAULT NULL
                            )
IS
      PRAGMA AUTONOMOUS_TRANSACTION;
      l_spec   DBMS_SQL.varchar2s;
      l_body   DBMS_SQL.varchar2s;

      PROCEDURE compile_statement (array_in IN DBMS_SQL.varchar2s)
IS
         l_cur   PLS_INTEGER := DBMS_SQL.open_cursor;
BEGIN
         DBMS_SQL.parse (l_cur
                       , array_in
                       , 1
                       , array_in.COUNT
                       , TRUE
                       , DBMS_SQL.native
                        );
         DBMS_SQL.close_cursor (l_cur);
END compile_statement;
BEGIN
      create_objects (dml_table_name         => dml_table_name
                    , err_log_table_name     => err_log_table_name
                    , err_log_table_owner    => err_log_table_owner
                    , err_log_table_space    => err_log_table_space
                    , skip_unsupported       => skip_unsupported
                    , overwrite_log_table    => overwrite_log_table
                    , err_log_package_name   => err_log_package_name
                    , err_log_package_spec   => l_spec
                    , err_log_package_body   => l_body
                     );
      compile_statement (l_spec);
      compile_statement (l_body);
EXCEPTION
      WHEN OTHERS THEN dbms_output.put_line (dbms_utility.format_error_backtrace); raise;
END create_objects;
END dbms_errlog_helper;

CREATE OR REPLACE PACKAGE ADBS_PAR_URL_CLIENT
IS
    NEXT_GET_PAR_URL          VARCHAR2(1024);
    COLLECTION_INDEX_POSITION NUMBER;
    ITEMS                     JSON_ARRAY_T;
    ITEMS_SIZE                NUMBER;
    TOTAL_RECORDS             NUMBER;

    PROCEDURE SET_PAR_URL(PAR_URL IN VARCHAR2);
    FUNCTION GET_NEXT_ITEM RETURN CLOB;
END;
/

CREATE OR REPLACE PACKAGE BODY ADBS_PAR_URL_CLIENT
IS
    PROCEDURE SET_PAR_URL(PAR_URL IN VARCHAR2)
    IS
BEGIN
        ADBS_PAR_URL_CLIENT.NEXT_GET_PAR_URL := PAR_URL;
        ADBS_PAR_URL_CLIENT.COLLECTION_INDEX_POSITION := 0;
        ADBS_PAR_URL_CLIENT.ITEMS := JSON_ARRAY_T('[]');
        ADBS_PAR_URL_CLIENT.ITEMS_SIZE := 0;
        ADBS_PAR_URL_CLIENT.TOTAL_RECORDS := 0;
END;

    FUNCTION GET_NEXT_ITEM
        RETURN CLOB
    IS
        HTTP_REQUEST  UTL_HTTP.REQ;
        HTTP_RESPONSE UTL_HTTP.RESP;
        RESPONSE_CODE NUMBER;
        RESPONSE_CONTENT  CLOB;
        TEMP_BUFFER   VARCHAR2(32767);
        LINKS JSON_ARRAY_T;
        HAS_MORE VARCHAR2(32767);
        JSON_OBJ JSON_OBJECT_T;
BEGIN

       IF ADBS_PAR_URL_CLIENT.COLLECTION_INDEX_POSITION < ADBS_PAR_URL_CLIENT.ITEMS_SIZE THEN
            ADBS_PAR_URL_CLIENT.COLLECTION_INDEX_POSITION := ADBS_PAR_URL_CLIENT.COLLECTION_INDEX_POSITION + 1;
RETURN ADBS_PAR_URL_CLIENT.ITEMS.GET(ADBS_PAR_URL_CLIENT.COLLECTION_INDEX_POSITION - 1).to_Clob;
ELSE
            IF ADBS_PAR_URL_CLIENT.NEXT_GET_PAR_URL IS NOT NULL THEN

                -- Iterate and remove each item from the global array
                FOR itemsIndx IN 0 .. ADBS_PAR_URL_CLIENT.ITEMS.get_size - 1
                LOOP
                    ADBS_PAR_URL_CLIENT.ITEMS.REMOVE(itemsIndx);
END LOOP;

                -- Initialize the CLOB.
                DBMS_LOB.CREATETEMPORARY(RESPONSE_CONTENT, false);

                HTTP_REQUEST := UTL_HTTP.BEGIN_REQUEST(ADBS_PAR_URL_CLIENT.NEXT_GET_PAR_URL, 'GET');
                UTL_HTTP.SET_HEADER(HTTP_REQUEST, 'CONTENT-TYPE', 'application/json');

                DBMS_OUTPUT.PUT_LINE('Invoking Get Request On Url: ' || ADBS_PAR_URL_CLIENT.NEXT_GET_PAR_URL);

                -- Get response.
                HTTP_RESPONSE := UTL_HTTP.GET_RESPONSE(HTTP_REQUEST);

                -- Status code
                RESPONSE_CODE := HTTP_RESPONSE.STATUS_CODE;
                DBMS_OUTPUT.PUT_LINE('Response received. STATUS=' || RESPONSE_CODE);
                DBMS_OUTPUT.PUT_LINE('Response received. REASON_PHRASE=' || HTTP_RESPONSE.reason_phrase);
                DBMS_OUTPUT.PUT_LINE('Response received. HTTP_VERSION=' || HTTP_RESPONSE.http_version);

                IF HTTP_RESPONSE.STATUS_CODE = 200 THEN
BEGIN
                        -- Copy the response into the intermediate CLOB.
                        LOOP
UTL_HTTP.READ_TEXT(HTTP_RESPONSE, TEMP_BUFFER, 32766);
                            RESPONSE_CONTENT := RESPONSE_CONTENT || TEMP_BUFFER;
END LOOP;

                        UTL_HTTP.END_RESPONSE(HTTP_RESPONSE);

EXCEPTION
                        WHEN UTL_HTTP.END_OF_BODY THEN
                            UTL_HTTP.END_RESPONSE(HTTP_RESPONSE);

WHEN OTHERS THEN
                            DBMS_OUTPUT.PUT_LINE(SQLERRM);
                            DBMS_OUTPUT.PUT_LINE(DBMS_UTILITY.FORMAT_ERROR_BACKTRACE);
                            UTL_HTTP.END_RESPONSE(HTTP_RESPONSE);
END;

                    JSON_OBJ := JSON_OBJECT_T( RESPONSE_CONTENT );
                    ADBS_PAR_URL_CLIENT.ITEMS := JSON_OBJ.GET_ARRAY('items');
                    DBMS_OUTPUT.PUT_LINE('size:' || ADBS_PAR_URL_CLIENT.ITEMS.get_size);
                    ADBS_PAR_URL_CLIENT.TOTAL_RECORDS := ADBS_PAR_URL_CLIENT.TOTAL_RECORDS + ADBS_PAR_URL_CLIENT.ITEMS.get_size;
                    ADBS_PAR_URL_CLIENT.COLLECTION_INDEX_POSITION := 0;
                    ADBS_PAR_URL_CLIENT.ITEMS_SIZE := ADBS_PAR_URL_CLIENT.ITEMS.get_size;

                    -- Get the links field from the json response
                    LINKS := JSON_OBJ.GET_ARRAY('links');

                    -- Iterate and get the next page href if available
FOR linksIndx IN 0 .. LINKS.get_size - 1
                    LOOP
                        IF JSON_OBJECT_T( LINKS.get(linksIndx)).GET_STRING('rel') = 'next' THEN
                            ADBS_PAR_URL_CLIENT.NEXT_GET_PAR_URL := JSON_OBJECT_T(LINKS.get(linksIndx)).GET_STRING('href');
                            DBMS_OUTPUT.PUT_LINE('next href: ' || ADBS_PAR_URL_CLIENT.NEXT_GET_PAR_URL);
END IF;
END LOOP;

                    -- Get the hasMore field from the json response
                    HAS_MORE := JSON_OBJ.GET_STRING('hasMore');
                    DBMS_OUTPUT.PUT_LINE('hasMore: ' || HAS_MORE);

                    IF HAS_MORE = 'false' THEN
                        ADBS_PAR_URL_CLIENT.NEXT_GET_PAR_URL := NULL;
END IF;

                    -- Relase the resources associated with the temporary LOB.
                    DBMS_LOB.FREETEMPORARY(RESPONSE_CONTENT);
                    ADBS_PAR_URL_CLIENT.COLLECTION_INDEX_POSITION := COLLECTION_INDEX_POSITION + 1;
RETURN ADBS_PAR_URL_CLIENT.ITEMS.GET(ADBS_PAR_URL_CLIENT.COLLECTION_INDEX_POSITION - 1).to_Clob;
ELSE
                    ADBS_PAR_URL_CLIENT.NEXT_GET_PAR_URL := NULL;
                    DBMS_OUTPUT.PUT_LINE('ERROR');
                    UTL_HTTP.END_RESPONSE(HTTP_RESPONSE);
RETURN NULL;
END IF;
ELSE
                RETURN NULL;
END IF;
END IF;
END;
END;
/

CREATE OR REPLACE PACKAGE plscope_demo
IS
   PROCEDURE my_procedure (param1_in IN INTEGER
                         , param2    IN employees.last_name%TYPE
                          );
END plscope_demo;
/

CREATE OR REPLACE PACKAGE BODY plscope_demo
IS
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
END plscope_demo;
/

CREATE OR REPLACE PACKAGE plscope_demo
IS
   public_global NUMBER;

   PROCEDURE my_procedure (param1_in IN INTEGER, param2 IN DATE);

   FUNCTION my_function (param1    IN INTEGER
                       , in_param2 INS DATE                  -- MY ERROR -> should be "IN"
                       , param3_in IN employees.last_name%TYPE
                        )
      RETURN VARCHAR2;
END plscope_demo;
/

CREATE OR REPLACE PACKAGE aa_pkg AUTHID DEFINER
IS
   TYPE record_t IS RECORD
      (nm VARCHAR2 (100), sal NUMBER);

   TYPE array_t IS TABLE OF record_t INDEX BY PLS_INTEGER;

   FUNCTION my_array RETURN array_t;
END;
/

CREATE OR REPLACE PACKAGE BODY aa_pkg
IS
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
END;
END;
/

CREATE OR REPLACE PACKAGE aa_pkg AUTHID DEFINER
IS
   TYPE record_t IS RECORD
   (
      idx   INTEGER,
      nm    VARCHAR2 (100),
      sal   NUMBER
   );

   TYPE array_t IS TABLE OF record_t INDEX BY PLS_INTEGER;

   FUNCTION my_array RETURN array_t;
END;
/

-- Same Package Body as Before
CREATE OR REPLACE PACKAGE BODY aa_pkg
IS
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
END;
/

CREATE OR REPLACE PACKAGE multdim AUTHID DEFINER
IS

   TYPE dim1_t IS TABLE OF VARCHR2 (32767) INDEX BY PLS_INTEGER;   -- MY ERROR -> should be "VARCHAR2"

   TYPE dim2_t IS TABLE OF dim1_t INDEX BY PLS_INTEGER;

   TYPE dim3_t IS TABLE OF dim2_t INDEX BY PLS_INTEGER;

   PROCEDURE setcell (
      array_in   IN OUT   dim3_t
     ,dim1_in             PLS_INTEGER
     ,dim2_in             PLS_INTEGER
     ,dim3_in             PLS_INTEGER
     ,value_in   IN       VARCHAR2
   );

   FUNCTION getcell (
      array_in   IN   dim3_t
     ,dim1_in         PLS_INTEGER
     ,dim2_in         PLS_INTEGER
     ,dim3_in         PLS_INTEGER
   )
      RETURN VARCHAR2;

   FUNCTION EXISTS (
      array_in   IN   dim3_t
     ,dim1_in         PLS_INTEGER
     ,dim2_in         PLS_INTEGER
     ,dim3_in         PLS_INTEGER
   )
      RETURN BOOLEAN;
END multdim;
/

CREATE OR REPLACE PACKAGE BODY multdim
IS
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
END multdim;
/

CREATE OR REPLACE PACKAGE authors_pkg
IS
   steven_authors   strings_nt;
   veva_authors     strings_nt;
   eli_authors      strings_nt;

   PROCEDURE show_authors (title_in IN VARCHAR2, authors_in IN strings_nt);

   PROCEDURE init_authors;
END;
/

CREATE OR REPLACE PACKAGE BODY authors_pkg
IS
   PROCEDURE show_authors (title_in IN VARCHAR2, authors_in IN strings_nt)
   IS
BEGIN
      DBMS_OUTPUT.put_line (title_in);

 indx IN 1 .. authors_in.COUNT                                              -- MY ERROR -> missed "FOR"
      LOOP
         DBMS_OUTPUT.put_line (indx || ' = ' || authors_in (indx));
END LOOP;
END show_authors;

   PROCEDURE init_authors
IS
BEGIN
      steven_authors :=
         strings_nt ('ROBIN HOBB'
                   , 'ROBERT HARRIS'
                   , 'DAVID BRIN'
                   , 'SHERI S. TEPPER'
                   , 'CHRISTOPHER ALEXANDER'
                   , 'PIERS ANTHONY');
      veva_authors :=
         strings_nt ('ROBIN HOBB', 'SHERI S. TEPPER', 'ANNE MCCAFFREY');

      eli_authors :=
         strings_nt ('PIERS ANTHONY', 'SHERI S. TEPPER', 'DAVID BRIN');
END;
END;
/

CREATE OR REPLACE PACKAGE assert
IS
   PROCEDURE assert (
      condition_in IN BOOLEAN
    , msg_in IN VARCHAR2
    , display_call_stack_in IN BOOLEAN DEFAULT FALSE
    , null_means_failure_in IN BOOLEAN DEFAULT TRUE
   );

   PROCEDURE is_null (
      val_in IN VARCHAR2
    , msg_in IN VARCHAR2
    , display_call_stack_in IN BOOLEAN DEFAULT FLSE             -- MY ERROR -> should be "FALSE"
   );

   PROCEDURE is_not_null (
      val_in IN VARCHAR2
    , msg_in IN VARCHAR2
    , display_call_stack_in IN BOOLEAN DEFAULT FALSE
   );

   PROCEDURE is_true (
      condition_in IN BOOLEAN
    , msg_in IN VARCHAR2
    , display_call_stack_in IN BOOLEAN DEFAULT FALSE
   );
END assert;
/

CREATE OR REPLACE PACKAGE BODY assert
IS
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

   PROCEDURE is_null (
      val_in IN VARCHAR2
    , msg_in IN VARCHAR2
    , display_call_stack_in IN BOOLEAN DEFAULT FALSE
   )
IS
BEGIN
      assert (val_in IS NULL
               , msg_in
               , display_call_stack_in
               , null_means_failure_in      => FALSE
                );
END is_null;

   PROCEDURE is_not_null (
      val_in IN VARCHAR2
    , msg_in IN VARCHAR2
    , display_call_stack_in IN BOOLEAN DEFAULT FALSE
   )
IS
BEGIN
      assert (val_in IS NOT NULL, msg_in, display_call_stack_in);
END is_not_null;

   PROCEDURE is_true (
      condition_in IN BOOLEAN
    , msg_in IN VARCHAR2
    , display_call_stack_in IN BOOLEAN DEFAULT FALSE
   )
IS
BEGIN
      assert (condition_in, msg_in, display_call_stack_in);
END is_true;
END assert;
/

CREATE OR REPLACE PACKAGE error_mgr
IS
   failure_in_forall   EXCEPTION;

   PRAGMA EXCEPTION_INIT (failure_in_forall, -24381);

   PROCEDURE log_error (app_info_in IN VARCHAR2);
END;
/

CREATE OR REPLACE PACKAGE BODY error_mgr
IS
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
END;
/

CREATE OR REPLACE PACKAGE my_utl_call_stack
   AUTHID DEFINER
IS
   FUNCTION format_call_stack  VARCHAR2;              -- MY ERROR -> missed "RETURN"
   FUNCTION format_error_stack RETURN VARCHAR2;
   FUNCTION format_error_backtrace RETURN VARCHAR2;
   FUNCTION backtrace_to RETURN VARCHAR2;
END;
/

CREATE OR REPLACE PACKAGE BODY my_utl_call_stack
IS
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
      /* 1 is always this function, so ignore it. */
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

   FUNCTION format_error_stack
      RETURN VARCHAR2
   IS
      l_return   VARCHAR2 (32767);
BEGIN
FOR indx IN 1 .. utl_call_stack.error_depth
      LOOP
         l_return :=
               l_return
            || case when l_return is not null then CHR (10) end
            || 'ORA-'
            || LPAD (TO_CHAR (utl_call_stack.error_number (indx)), 5, '0')
            || ': '
            || utl_call_stack.error_msg (indx);
END LOOP;

RETURN l_return;
END;

   FUNCTION format_error_backtrace
      RETURN VARCHAR2
   IS
      l_return   VARCHAR2 (32767);
BEGIN
FOR indx IN 1 .. utl_call_stack.backtrace_depth
      LOOP
         l_return :=
               l_return
            || case when l_return is not null then CHR (10) end
            || indx
            || ' -> '
            || utl_call_stack.backtrace_unit (indx)
            || ' - Line '
            || TO_CHAR (utl_call_stack.backtrace_line (indx));
END LOOP;

RETURN l_return;
EXCEPTION
      WHEN OTHERS
      THEN
         IF SQLCODE = -64610
         THEN
            /* ORA-64610: bad depth indicator */
            RETURN l_return;
ELSE
            RAISE;
END IF;
END;

   FUNCTION backtrace_to
      RETURN VARCHAR2
   IS
BEGIN
RETURN    utl_call_stack.backtrace_unit (1)
    || ' on line '
    || utl_call_stack.backtrace_line (1);
END;
END;
/