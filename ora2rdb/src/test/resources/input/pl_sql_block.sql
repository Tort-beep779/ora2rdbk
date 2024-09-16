BEGIN
   methods_data.my_family.DELETE (5, 7);
END;
/



BEGIN
   methods_data.my_family :=
      methods_data.names_t ('Veva',
               'Chris',
               'Eli',
               'Lauren',
               'Loey',
               'Juna',
               'Steven');
END;
/



DECLARE
my_3d_array   multdim.dim3_t;
BEGIN
   multdim.setcell (my_3d_array, 1, 5, 800, 'def');
   multdim.setcell (my_3d_array, 1, 15, 800, 'def');
   multdim.setcell (my_3d_array, 5, 5, 800, 'def');
   multdim.setcell (my_3d_array, 5, 5, 805, 'def');

   DBMS_OUTPUT.PUT_LINE (multdim.getcell (my_3d_array, 1, 5, 800));
   bpl (multdim.EXISTS (my_3d_array, 1, 5, 800));
   bpl (multdim.EXISTS (my_3d_array, 6000, 5, 800));
   bpl (multdim.EXISTS (my_3d_array, 6000, 5, 807));

   DBMS_OUTPUT.PUT_LINE (my_3d_array.COUNT);
END;
/



DECLARE
TYPE ints_t IS TABLE OF INTEGER
      INDEX BY PLS_INTEGER;

   l_ints   ints_t;
BEGIN
FOR indx IN 1 .. l_ints.COUNT
   LOOP
      DBMS_OUTPUT.put_line (l_ints (indx));
END LOOP;
END;
/



DECLARE
name NUMBER;
    TYPE population IS TABLE OF NUMBER
        INDEX BY VARCHAR2(64);
    city_population  population;
    i  VARCHAR2(64);
BEGIN
    name := 100;
    Get_(name);
END;



DECLARE
TYPE ints_t IS TABLE OF INTEGER
      INDEX BY PLS_INTEGER;

   l_ints   ints_t;
BEGIN
   l_ints (1) := 55;
   l_ints (2) := 555;
   l_ints (3) := 5555;

FOR indx IN 1 .. l_ints.COUNT
   LOOP
      DBMS_OUTPUT.put_line (l_ints (indx));
END LOOP;
END;
/




DECLARE
TYPE ints_t IS TABLE OF INTEGER
      INDEX BY PLS_INTEGER;

   l_ints   ints_t := ints_t;
BEGIN
FOR indx IN 1 .. l_ints.COUNT
   LOOP
      DBMS_OUTPUT.put_line (l_ints (indx));
END LOOP;
END;
/



DECLARE
TYPE ints_t IS TABLE OF INTEGER
      INDEX BY PLS_INTEGER;

   l_ints   ints_t;
BEGIN
   DBMS_OUTPUT.PUT_LINE (l_ints.COUNT);
END;
/





DECLARE
TYPE ints_t IS TABLE OF INTEGER
      INDEX BY PLS_INTEGER;

   l_ints   ints_t;
   l_index  INTEGER;
BEGIN
   l_ints := ints_t;

   l_index := l_ints.first;

   WHILE l_index IS NOT NULL
   LOOP
      DBMS_OUTPUT.put_line (l_index || ' => ' || l_ints (l_index));
      l_index := l_ints.NEXT (l_index);
END LOOP;
END;
/


DECLARE
TYPE employee_ntt IS TABLE OF employees%ROWTYPE;

   l_employees   employee_ntt;
BEGIN
EXECUTE IMMEDIATE 'SELECT * FROM employees' BULK COLLECT INTO l_employees;

DBMS_OUTPUT.put_line (l_employees.COUNT);
END;
/


DECLARE
l_cursor      SYS_REFCURSOR;

   TYPE employee_ntt IS TABLE OF employees%ROWTYPE;

   l_employees   employee_ntt;
BEGIN
OPEN l_cursor FOR 'SELECT * FROM employees';

LOOP
FETCH l_cursor BULK COLLECT INTO l_employees LIMIT 100;

      EXIT WHEN l_employees.COUNT = 0;

      DBMS_OUTPUT.put_line (l_employees.COUNT);
END LOOP;

CLOSE l_cursor;
END;
/




DECLARE
l_company_id   INTEGER;
BEGIN
   IF l_company_id IS NULL
   THEN
      RAISE VALUE_ERROR;
END IF;
EXCEPTION
   WHEN OTHERS
   THEN
      error_mgr.log_error ('Company ID is NULL - not allowed.');
END;
/




DECLARE
CURSOR emps_cur
   IS
SELECT * FROM employees;
BEGIN
FOR rec IN emps_cur
   LOOP
      DBMS_OUTPUT.put_line (rec.last_name);
END LOOP;

FOR rec IN emps_cur
   LOOP
      DBMS_OUTPUT.put_line (rec.salary);
END LOOP;
END;
/





DECLARE
CURSOR emps_cur (department_id_in IN INTEGER)
   IS
SELECT * FROM employees
WHERE department_id = department_id_in;
BEGIN
FOR rec IN emps_cur (1700)
   LOOP
      DBMS_OUTPUT.put_line (rec.last_name);
END LOOP;

FOR rec IN emps_cur (50)
   LOOP
      DBMS_OUTPUT.put_line (rec.salary);
END LOOP;
END;
/




CREATE OR REPLACE PROCEDURE Get_ (out_parameter IN OUT NUMBER)
  IS
BEGIN
   out_parameter := out_parameter + 4;
END Get_;
/
DECLARE
name NUMBER;
BEGIN
    name := 100;
    Get_(name);
END;




DECLARE
CURSOR c1 RETURN departments%ROWTYPE;

CURSOR c2 IS
SELECT employee_id, job_id, salary FROM employees
WHERE salary > 2000;

CURSOR c1 RETURN departments%ROWTYPE IS
SELECT * FROM departments
WHERE department_id = 110;

CURSOR c3 RETURN locations%ROWTYPE;

CURSOR c3 IS
SELECT * FROM locations
WHERE country_id = 'JP';
BEGIN
NULL;
END;
/




BEGIN
FOR i IN REVERSE 1..3 LOOP
    null;
END LOOP;
END;
/

BEGIN
FOR i IN REVERSE 1..3 LOOP
    null;
END LOOP;

FOR j IN  1..3 LOOP
    null;
END LOOP;
END;
/


DECLARE

CURSOR c1 IS
SELECT employee_id, first_name, last_name, salary
FROM employees
WHERE department_id = 10;

BEGIN

FOR employee_rec IN c1 LOOP
    DBMS_OUTPUT.PUT_LINE('Employee ID: ' || employee_rec.employee_id ||
                         ', Name: ' || employee_rec.first_name || ' ' || employee_rec.last_name ||
                         ', Salary: ' || employee_rec.salary);
END LOOP;
END;
/


DECLARE
l_common_name   endangered_species.common_name%TYPE;
BEGIN
SELECT common_name
INTO l_common_name
FROM endangered_species
WHERE species_name = 'Rhinoceros sondaicus';
EXCEPTION
   WHEN NO_DATA_FOUND
   THEN
      DBMS_OUTPUT.put_line ('Error or data condition?');
WHEN TOO_MANY_ROWS
   THEN
      DBMS_OUTPUT.put_line ('Error if primary key/unique index lookup!');
END;
/

DECLARE
    v_outer_variable VARCHAR2(100) := 'Внешняя переменная';
BEGIN
    DBMS_OUTPUT.PUT_LINE('Внешний блок: ' || v_outer_variable);
    DECLARE
        v_inner_variable VARCHAR2(100) := 'Внутренняя переменная';
    BEGIN
        DBMS_OUTPUT.PUT_LINE('Внутренний блок: ' || v_inner_variable);
        DBMS_OUTPUT.PUT_LINE('Доступ к внешней переменной из внутреннего блока: ' || v_outer_variable);
    END;
    DBMS_OUTPUT.PUT_LINE('Обратно во внешний блок: ' || v_outer_variable);
END;
/

