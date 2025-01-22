/* Здесь приведены некоторые примеры использования куросрной переменной в ORACLE */

-- https://docs.oracle.com/en/database/oracle/oracle-database/21/lnpls/static-sql.html#GUID-AA5A2016-1B76-4961-9AFB-EB052F0D0FB2:~:text=Example%207%2D26%20Fetching%20Data%20with%20Cursor%20Variables
DECLARE
cv SYS_REFCURSOR;  -- cursor variable

  v_lastname  employees.last_name%TYPE;  -- variable for last_name
  v_jobid     employees.job_id%TYPE;     -- variable for job_id

  query_2 VARCHAR2(200) :=
    'SELECT * FROM employees
    WHERE REGEXP_LIKE (job_id, ''[ACADFIMKSA]_M[ANGR]'')
    ORDER BY job_id';

  v_employees employees%ROWTYPE;  -- record variable row of table

BEGIN
OPEN cv FOR
SELECT last_name, job_id FROM employees
WHERE REGEXP_LIKE (job_id, 'S[HT]_CLERK')
ORDER BY last_name;

LOOP  -- Fetches 2 columns into variables
FETCH cv INTO v_lastname, v_jobid;
    EXIT WHEN cv%NOTFOUND;
    DBMS_OUTPUT.PUT_LINE( RPAD(v_lastname, 25, ' ') || v_jobid );
END LOOP;

  DBMS_OUTPUT.PUT_LINE( '-------------------------------------' );

OPEN cv FOR query_2;

LOOP  -- Fetches entire row into the v_employees record
FETCH cv INTO v_employees;
    EXIT WHEN cv%NOTFOUND;
    DBMS_OUTPUT.PUT_LINE( RPAD(v_employees.last_name, 25, ' ') ||
                               v_employees.job_id );
END LOOP;

CLOSE cv;
END;
/


-- пример из книжки Фейрштейна
-- создается курсорная переменная building_curvar, которая передается как OUT параметр
-- в процедуру open_site_list где открывается (OPEN ... FOR)
DECLARE
   /* Declare a cursor variable. */
building_curvar   sys_refcursor;

   address_string    property_master.address%TYPE;

   /* Define record structures for two different tables. */
   home_rec          home_properties%ROWTYPE;
   commercial_rec    commercial_properties%ROWTYPE;

   FUNCTION current_address
      RETURN VARCHAR2
   IS
BEGIN
RETURN NULL;
END;

   PROCEDURE open_site_list (address_in IN     property_master.address%TYPE
                           , cv_out        OUT sys_refcursor
                            )
    IS
    BEGIN
            OPEN cv_out FOR
            SELECT *
            FROM home_properties;
END;


   /* Assign a query to the cursor variable based on the address. */
   open_site_list (address_string, building_curvar);

   /* Give it a try! Fetch a row into the home record. */
FETCH building_curvar
    INTO home_rec;

/* If I got here, the site was a home, so display it. */
show_home_site (home_rec);
EXCEPTION
   /* If the first record was not a home... */
   WHEN ROWTYPE_MISMATCH
   THEN
      /* Fetch that same 1st row into the commercial record. */
      FETCH building_curvar
      INTO commercial_rec;

      /* Show the commercial site info. */
      show_commercial_site (commercial_rec);
END;
/

-- https://docs.oracle.com/en/database/oracle/oracle-database/21/lnpls/static-sql.html#GUID-E03A2A12-D298-4D1C-8CCE-3B5D17DDFC7C:~:text=Example%207%2D28%20Variable%20in%20Cursor%20Variable%20Query%E2%80%94No%20Result%20Set%20Change
DECLARE
sal           employees.salary%TYPE;
  sal_multiple  employees.salary%TYPE;
  factor        INTEGER := 2;

  cv SYS_REFCURSOR;

BEGIN
OPEN cv FOR
SELECT salary, salary*factor
FROM employees
WHERE job_id LIKE 'AD_%';   -- PL/SQL evaluates factor

LOOP
FETCH cv INTO sal, sal_multiple;
    EXIT WHEN cv%NOTFOUND;
    DBMS_OUTPUT.PUT_LINE('factor = ' || factor);
    DBMS_OUTPUT.PUT_LINE('sal          = ' || sal);
    DBMS_OUTPUT.PUT_LINE('sal_multiple = ' || sal_multiple);
    factor := factor + 1;  -- Does not affect sal_multiple
END LOOP;

CLOSE cv;
END;
/
