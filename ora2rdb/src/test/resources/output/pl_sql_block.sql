CREATE EXCEPTION NO_DATA_FOUND
	'no data found';

EXECUTE BLOCK 
 AS 

   BEGIN
methods_data.my_family.DELETE (5, 7);
END;






EXECUTE BLOCK 
 AS 

   BEGIN
methods_data.my_family =
      methods_data.names_t ('Veva',
               'Chris',
               'Eli',
               'Lauren',
               'Loey',
               'Juna',
               'Steven');
END;






EXECUTE BLOCK 
 AS 

DECLARE my_3d_array   multdim.dim3_t;

   BEGIN
multdim.setcell (:my_3d_array, 1, 5, 800, 'def');
   multdim.setcell (:my_3d_array, 1, 15, 800, 'def');
   multdim.setcell (:my_3d_array, 5, 5, 800, 'def');
   multdim.setcell (:my_3d_array, 5, 5, 805, 'def');

   DBMS_OUTPUT.PUT_LINE (multdim.getcell (:my_3d_array, 1, 5, 800));
   bpl (multdim.EXISTS (:my_3d_array, 1, 5, 800));
   bpl (multdim.EXISTS (:my_3d_array, 6000, 5, 800));
   bpl (multdim.EXISTS (:my_3d_array, 6000, 5, 807));

   DBMS_OUTPUT.PUT_LINE (my_3d_array.COUNT);
END;





CREATE GLOBAL TEMPORARY TABLE L_INTS (
	I1 PLS_INTEGER,
	VAL INTEGER,
	CONSTRAINT PK_L_INTS PRIMARY KEY (I1)
);


EXECUTE BLOCK 
 AS 

/*TYPE ints_t IS TABLE OF INTEGER
      INDEX BY PLS_INTEGER;*/

   /*l_ints   ints_t;*/


  DECLARE VARIABLE indx INTEGER;
BEGIN
indx = 1;
WHILE ( indx  <=    l_ints.COUNT) DO
BEGIN
   
      DBMS_OUTPUT.put_line ((SELECT VAL FROM L_INTS WHERE I1 = :indx));
indx = indx + 1;
END
 
END;





CREATE GLOBAL TEMPORARY TABLE CITY_POPULATION (
	I1 VARCHAR(64),
	VAL NUMERIC(18, 4),
	CONSTRAINT PK_CITY_POPULATION PRIMARY KEY (I1)
);


EXECUTE BLOCK 
 AS 

DECLARE name NUMERIC(18, 4);
    /*TYPE population IS TABLE OF NUMERIC(18, 4)
        INDEX BY VARCHAR(64);*/
    /*city_population  population;*/
    DECLARE i  VARCHAR(64);

    BEGIN
name = 100;
    SELECT OUT_PARAMETER_OUT  FROM Get_(:name) INTO name;
END;




CREATE GLOBAL TEMPORARY TABLE L_INTS1 (
	I1 PLS_INTEGER,
	VAL INTEGER,
	CONSTRAINT PK_L_INTS1 PRIMARY KEY (I1)
);


EXECUTE BLOCK 
 AS 

/*TYPE ints_t IS TABLE OF INTEGER
      INDEX BY PLS_INTEGER;*/

   /*l_ints   ints_t;*/

   
  DECLARE VARIABLE indx INTEGER;
BEGIN
   UPDATE OR INSERT INTO L_INTS1 VALUES (1, 55);
   UPDATE OR INSERT INTO L_INTS1 VALUES (2, 555);
   UPDATE OR INSERT INTO L_INTS1 VALUES (3, 5555);

indx = 1;
WHILE ( indx  <=    l_ints.COUNT) DO
BEGIN
   
      DBMS_OUTPUT.put_line ((SELECT VAL FROM L_INTS1 WHERE I1 = :indx));
indx = indx + 1;
END
 
END;






CREATE GLOBAL TEMPORARY TABLE L_INTS2 (
	I1 PLS_INTEGER,
	VAL INTEGER,
	CONSTRAINT PK_L_INTS2 PRIMARY KEY (I1)
);


EXECUTE BLOCK 
 AS 

/*TYPE ints_t IS TABLE OF INTEGER
      INDEX BY PLS_INTEGER;*/

   /*l_ints   ints_t = ints_t;*/


  DECLARE VARIABLE indx INTEGER;
BEGIN
indx = 1;
WHILE ( indx  <=    l_ints.COUNT) DO
BEGIN
   
      DBMS_OUTPUT.put_line ((SELECT VAL FROM L_INTS2 WHERE I1 = :indx));
indx = indx + 1;
END
 
END;





CREATE GLOBAL TEMPORARY TABLE L_INTS3 (
	I1 PLS_INTEGER,
	VAL INTEGER,
	CONSTRAINT PK_L_INTS3 PRIMARY KEY (I1)
);


EXECUTE BLOCK 
 AS 

/*TYPE ints_t IS TABLE OF INTEGER
      INDEX BY PLS_INTEGER;*/

   /*l_ints   ints_t;*/

   BEGIN
DBMS_OUTPUT.PUT_LINE (l_ints.COUNT);
END;







CREATE GLOBAL TEMPORARY TABLE L_INTS4 (
	I1 PLS_INTEGER,
	VAL INTEGER,
	CONSTRAINT PK_L_INTS4 PRIMARY KEY (I1)
);


EXECUTE BLOCK 
 AS 

/*TYPE ints_t IS TABLE OF INTEGER
      INDEX BY PLS_INTEGER;*/

   /*l_ints   ints_t;*/
   DECLARE l_index  INTEGER;

   BEGIN
l_ints = ints_t;

   l_index = l_ints.first;

   WHILE (:l_index IS NOT NULL) DO
   
   BEGIN
      DBMS_OUTPUT.put_line (:l_index || ' => ' || (SELECT VAL FROM L_INTS4 WHERE I1 = :l_index));
      l_index = l_ints.NEXT (:l_index);
   END
 
END;





EXECUTE BLOCK 
 AS 

/*TYPE employee_ntt IS TABLE OF TYPE OF TABLE employees;*/

   DECLARE l_employees   employee_ntt;

BEGIN
EXECUTE STATEMENT ('SELECT * FROM employees')  BULK COLLECT INTO :l_employees;

DBMS_OUTPUT.put_line (l_employees.COUNT);
END;





EXECUTE BLOCK 
 AS 

DECLARE l_cursor      SYS_REFCURSOR;

   /*TYPE employee_ntt IS TABLE OF TYPE OF TABLE employees;*/

   DECLARE l_employees   employee_ntt;

BEGIN
OPEN :l_cursor FOR 'SELECT * FROM employees';

WHILE (TRUE) DO BEGIN
FETCH :l_cursor BULK COLLECT INTO :l_employees LIMIT 100;

        IF( l_employees.COUNT = 0 ) BEGIN LEAVE END;

      DBMS_OUTPUT.put_line (l_employees.COUNT);
END 

CLOSE :l_cursor;
END;







EXECUTE BLOCK 
 AS 

DECLARE l_company_id   INTEGER;

   BEGIN
IF (:l_company_id IS NULL)
   THEN
      RAISE VALUE_ERROR;
 
/*EXCEPTION*/
   WHEN OTHERS
   DO
      BEGIN
	      error_mgr.log_error ('Company ID is NULL - not allowed.');
      END
END;







EXECUTE BLOCK 
 AS 

DECLARE emps_cur
   CURSOR FOR
(SELECT * FROM employees);


  DECLARE VARIABLE EMPS_CUR_REC TYPE OF TABLE EMPS_CUR;
BEGIN

OPEN EMPS_CUR;
FETCH EMPS_CUR INTO EMPS_CUR_REC;
WHILE ( ROW_COUNT != 0 ) DO 
   
BEGIN
      DBMS_OUTPUT.put_line (EMPS_CUR_REC.last_name);
	FETCH EMPS_CUR INTO EMPS_CUR_REC;
END
 
CLOSE EMPS_CUR;



OPEN EMPS_CUR;
FETCH EMPS_CUR INTO EMPS_CUR_REC;
WHILE ( ROW_COUNT != 0 ) DO 
   
BEGIN
      DBMS_OUTPUT.put_line (EMPS_CUR_REC.salary);
	FETCH EMPS_CUR INTO EMPS_CUR_REC;
END
 
CLOSE EMPS_CUR;

END;








EXECUTE BLOCK 
 AS 

DECLARE emps_cur (department_id_in IN INTEGER)
   CURSOR FOR
(SELECT * FROM employees
WHERE department_id = department_id_in);

BEGIN
FOR rec IN emps_cur (1700)
DO
BEGIN
   
      DBMS_OUTPUT.put_line (rec.last_name);
END
 

FOR rec IN emps_cur (50)
DO
BEGIN
   
      DBMS_OUTPUT.put_line (rec.salary);
END
 
END;







CREATE OR ALTER PROCEDURE Get_ (out_parameter   NUMERIC(18, 4))
  RETURNS ( OUT_PARAMETER_OUT NUMERIC(18, 4))

AS
BEGIN
   out_parameter = :out_parameter + 4;

OUT_PARAMETER_OUT = OUT_PARAMETER;
SUSPEND;
END /*Get_*/;



EXECUTE BLOCK 
 AS 

DECLARE name NUMERIC(18, 4);

    BEGIN
name = 100;
    SELECT OUT_PARAMETER_OUT  FROM Get_(:name) INTO name;
END;






EXECUTE BLOCK 
 AS 

DECLARE c1 RETURN TYPE OF TABLE departments;

DECLARE c2 CURSOR FOR
(SELECT employee_id, job_id, salary FROM employees
WHERE salary > 2000);

DECLARE c1 RETURN TYPE OF TABLE departments CURSOR FOR
(SELECT * FROM departments
WHERE department_id = 110);

DECLARE c3 RETURN TYPE OF TABLE locations;

DECLARE c3 CURSOR FOR
(SELECT * FROM locations
WHERE country_id = 'JP');

BEGIN
NULL;
END;







EXECUTE BLOCK 
 AS 


  DECLARE VARIABLE i INTEGER;
BEGIN
i = 3;
WHILE ( i  >=   1) DO
BEGIN 
    null;
i = i - 1;
END
 
END;




EXECUTE BLOCK 
 AS 


  DECLARE VARIABLE i INTEGER;

  DECLARE VARIABLE j INTEGER;
BEGIN
i = 3;
WHILE ( i  >=   1) DO
BEGIN 
    null;
i = i - 1;
END
 

j = 1;
WHILE ( j  <=   3) DO
BEGIN 
    null;
j = j + 1;
END
 
END;





EXECUTE BLOCK 
 AS 


DECLARE c1 CURSOR FOR
(SELECT employee_id, first_name, last_name, salary
FROM employees
WHERE department_id = 10);




  DECLARE VARIABLE C1_EMPLOYEE_REC TYPE OF TABLE C1;
BEGIN

OPEN C1;
FETCH C1 INTO C1_EMPLOYEE_REC;
WHILE ( ROW_COUNT != 0 ) DO  
BEGIN
    DBMS_OUTPUT.PUT_LINE('Employee ID: ' || C1_EMPLOYEE_REC.employee_id ||
                         ', Name: ' || C1_EMPLOYEE_REC.first_name || ' ' || C1_EMPLOYEE_REC.last_name ||
                         ', Salary: ' || C1_EMPLOYEE_REC.salary);
	FETCH C1 INTO C1_EMPLOYEE_REC;
END
 
CLOSE C1;

END;





EXECUTE BLOCK 
 AS 

DECLARE l_common_name   TYPE OF COLUMN endangered_species.common_name;

BEGIN
SELECT common_name


FROM endangered_species
WHERE species_name = 'Rhinoceros sondaicus'
INTO :l_common_name;
IF (ROW_COUNT = 0) THEN
	EXCEPTION NO_DATA_FOUND;
/*EXCEPTION*/
   WHEN EXCEPTION NO_DATA_FOUND
   DO
      BEGIN
	      DBMS_OUTPUT.put_line ('Error or data condition?');
      END
WHEN GDSCODE SING_SELECT_ERR
   DO
      BEGIN
	      DBMS_OUTPUT.put_line ('Error if primary key/unique index lookup!');
      END
END;



/*Multilevel nesting of an anonymous block is not supported in Red Database*/ 
/*DECLARE
    DECLARE v_outer_variable VARCHAR(100) = 'Внешняя переменная';
BEGIN
    DBMS_OUTPUT.PUT_LINE('Внешний блок: ' || :v_outer_variable);
    DECLARE
        DECLARE v_inner_variable VARCHAR(100) = 'Внутренняя переменная';
    BEGIN
        DBMS_OUTPUT.PUT_LINE('Внутренний блок: ' || :v_inner_variable);
        DBMS_OUTPUT.PUT_LINE('Доступ к внешней переменной из внутреннего блока: ' || :v_outer_variable);
    END;
    DBMS_OUTPUT.PUT_LINE('Обратно во внешний блок: ' || :v_outer_variable);
END;*/


