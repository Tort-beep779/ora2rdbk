CREATE EXCEPTION NO_DATA_FOUND
	'no data found';
CREATE SEQUENCE  "DEPARTMENTS_SEQ"           ;
ALTER SEQUENCE "DEPARTMENTS_SEQ" RESTART WITH 280;

CREATE SEQUENCE  "EMPLOYEES_SEQ"           ;
ALTER SEQUENCE "EMPLOYEES_SEQ" RESTART WITH 207;

CREATE SEQUENCE  "LOCATIONS_SEQ"           ;
ALTER SEQUENCE "LOCATIONS_SEQ" RESTART WITH 3300;

CREATE TABLE "COUNTRIES"
   (	"COUNTRY_ID" CHAR(2 ) NOT NULL, 
	"COUNTRY_NAME" VARCHAR(40 ), 
	"REGION_ID" NUMERIC(18, 4)

   )  ;

CREATE TABLE "DEPARTMENTS"
   (	"DEPARTMENT_ID" NUMERIC(4,0) NOT NULL, 
	"DEPARTMENT_NAME" VARCHAR(30 ) NOT NULL, 
	"MANAGER_ID" NUMERIC(6,0), 
	"LOCATION_ID" NUMERIC(4,0)
   ) ;

CREATE TABLE "EMPLOYEES"
   (	"EMPLOYEE_ID" NUMERIC(6,0) NOT NULL, 
	"FIRST_NAME" VARCHAR(20 ), 
	"LAST_NAME" VARCHAR(25 ) NOT NULL, 
	"EMAIL" VARCHAR(25 ) NOT NULL, 
	"PHONE_NUMBER" VARCHAR(20 ), 
	"HIRE_DATE" DATE NOT NULL, 
	"JOB_ID" VARCHAR(10 ) NOT NULL, 
	"SALARY" NUMERIC(8,2), 
	"COMMISSION_PCT" NUMERIC(2,2), 
	"MANAGER_ID" NUMERIC(6,0), 
	"DEPARTMENT_ID" NUMERIC(4,0)
   ) ;

CREATE TABLE "JOB_HISTORY"
   (	"EMPLOYEE_ID" NUMERIC(6,0) NOT NULL, 
	"START_DATE" DATE NOT NULL, 
	"END_DATE" DATE NOT NULL, 
	"JOB_ID" VARCHAR(10 ) NOT NULL, 
	"DEPARTMENT_ID" NUMERIC(4,0)
   ) ;

CREATE TABLE "JOBS"
   (	"JOB_ID" VARCHAR(10 ) NOT NULL, 
	"JOB_TITLE" VARCHAR(35 ) NOT NULL, 
	"MIN_SALARY" NUMERIC(6,0), 
	"MAX_SALARY" NUMERIC(6,0)
   ) ;

CREATE TABLE "LOCATIONS"
   (	"LOCATION_ID" NUMERIC(4,0) NOT NULL, 
	"STREET_ADDRESS" VARCHAR(40 ), 
	"POSTAL_CODE" VARCHAR(12 ), 
	"CITY" VARCHAR(30 ) NOT NULL, 
	"STATE_PROVINCE" VARCHAR(25 ), 
	"COUNTRY_ID" CHAR(2 )
   ) ;

CREATE TABLE "REGIONS"
   (	"REGION_ID" NUMERIC(18, 4) NOT NULL, 
	"REGION_NAME" VARCHAR(25 )
   ) ;

CREATE OR ALTER  VIEW "EMP_DETAILS_VIEW" ("EMPLOYEE_ID", "JOB_ID", "MANAGER_ID", "DEPARTMENT_ID", "LOCATION_ID", "COUNTRY_ID", "FIRST_NAME", "LAST_NAME", "SALARY", "COMMISSION_PCT", "DEPARTMENT_NAME", "JOB_TITLE", "CITY", "STATE_PROVINCE", "COUNTRY_NAME", "REGION_NAME") AS
  SELECT
  e.employee_id,
  e.job_id,
  e.manager_id,
  e.department_id,
  d.location_id,
  l.country_id,
  e.first_name,
  e.last_name,
  e.salary,
  e.commission_pct,
  d.department_name,
  j.job_title,
  l.city,
  l.state_province,
  c.country_name,
  r.region_name
FROM
  employees e,
  departments d,
  jobs j,
  locations l,
  countries c,
  regions r
WHERE e.department_id = d.department_id
  AND d.location_id = l.location_id
  AND l.country_id = c.country_id
  AND c.region_id = r.region_id
  AND j.job_id = e.job_id
;

COMMENT ON TABLE "COUNTRIES"  IS 'country table. Contains 25 rows. References with locations table.';

COMMENT ON TABLE "DEPARTMENTS"  IS 'Departments table that shows details of departments where employees
work. Contains 27 rows; references with locations, employees, and job_history tables.';

COMMENT ON TABLE "EMPLOYEES"  IS 'employees table. Contains 107 rows. References with departments,
jobs, job_history tables. Contains a self reference.';

COMMENT ON TABLE "JOB_HISTORY"  IS 'Table that stores job history of the employees. If an employee
changes departments within the job or changes jobs within the department,
new rows get inserted into this table with old job information of the
employee. Contains a complex primary key: employee_id+start_date.
Contains 25 rows. References with jobs, employees, and departments tables.';

COMMENT ON TABLE "JOBS"  IS 'jobs table with job titles and salary ranges. Contains 19 rows.
References with employees and job_history table.';

COMMENT ON TABLE "LOCATIONS"  IS 'Locations table that contains specific address of a specific office,
warehouse, and/or production site of a company. Does not store addresses /
locations of customers. Contains 23 rows; references with the
departments and countries tables. ';

ALTER TABLE "REGIONS" ADD CONSTRAINT "REG_ID_PK" PRIMARY KEY ("REGION_ID") ;

ALTER TABLE "LOCATIONS" ADD CONSTRAINT "LOC_ID_PK" PRIMARY KEY ("LOCATION_ID") ;

ALTER TABLE "EMPLOYEES" ADD CONSTRAINT "EMP_EMP_ID_PK" PRIMARY KEY ("EMPLOYEE_ID") ;

ALTER TABLE "EMPLOYEES" ADD CONSTRAINT "EMP_EMAIL_UK" UNIQUE ("EMAIL") ;

ALTER TABLE "EMPLOYEES" ADD CONSTRAINT "EMP_SALARY_MIN" CHECK (salary > 0) ;

ALTER TABLE "DEPARTMENTS" ADD CONSTRAINT "DEPT_ID_PK" PRIMARY KEY ("DEPARTMENT_ID") ;

ALTER TABLE "JOB_HISTORY" ADD CONSTRAINT "JHIST_EMP_ID_ST_DATE_PK" PRIMARY KEY ("EMPLOYEE_ID", "START_DATE") ;

ALTER TABLE "JOB_HISTORY" ADD CONSTRAINT "JHIST_DATE_INTERVAL" CHECK (end_date > start_date) ;

ALTER TABLE "COUNTRIES" ADD CONSTRAINT "COUNTRY_C_ID_PK" PRIMARY KEY ("COUNTRY_ID") ;

ALTER TABLE "JOBS" ADD CONSTRAINT "JOB_ID_PK" PRIMARY KEY ("JOB_ID") ;

ALTER TABLE "COUNTRIES" ADD CONSTRAINT "COUNTR_REG_FK" FOREIGN KEY ("REGION_ID")
	  REFERENCES "REGIONS" ("REGION_ID") ;

ALTER TABLE "DEPARTMENTS" ADD CONSTRAINT "DEPT_LOC_FK" FOREIGN KEY ("LOCATION_ID")
	  REFERENCES "LOCATIONS" ("LOCATION_ID") ;

ALTER TABLE "DEPARTMENTS" ADD CONSTRAINT "DEPT_MGR_FK" FOREIGN KEY ("MANAGER_ID")
	  REFERENCES "EMPLOYEES" ("EMPLOYEE_ID") ;

ALTER TABLE "EMPLOYEES" ADD CONSTRAINT "EMP_DEPT_FK" FOREIGN KEY ("DEPARTMENT_ID")
	  REFERENCES "DEPARTMENTS" ("DEPARTMENT_ID") ;

ALTER TABLE "EMPLOYEES" ADD CONSTRAINT "EMP_JOB_FK" FOREIGN KEY ("JOB_ID")
	  REFERENCES "JOBS" ("JOB_ID") ;

ALTER TABLE "EMPLOYEES" ADD CONSTRAINT "EMP_MANAGER_FK" FOREIGN KEY ("MANAGER_ID")
	  REFERENCES "EMPLOYEES" ("EMPLOYEE_ID") ;

ALTER TABLE "JOB_HISTORY" ADD CONSTRAINT "JHIST_DEPT_FK" FOREIGN KEY ("DEPARTMENT_ID")
	  REFERENCES "DEPARTMENTS" ("DEPARTMENT_ID") ;

ALTER TABLE "JOB_HISTORY" ADD CONSTRAINT "JHIST_EMP_FK" FOREIGN KEY ("EMPLOYEE_ID")
	  REFERENCES "EMPLOYEES" ("EMPLOYEE_ID") ;

ALTER TABLE "JOB_HISTORY" ADD CONSTRAINT "JHIST_JOB_FK" FOREIGN KEY ("JOB_ID")
	  REFERENCES "JOBS" ("JOB_ID") ;

ALTER TABLE "LOCATIONS" ADD CONSTRAINT "LOC_C_ID_FK" FOREIGN KEY ("COUNTRY_ID")
	  REFERENCES "COUNTRIES" ("COUNTRY_ID") ;

CREATE INDEX "LOC_STATE_PROVINCE_IX" ON "LOCATIONS" ("STATE_PROVINCE")
  ;

CREATE INDEX "EMP_DEPARTMENT_IX" ON "EMPLOYEES" ("DEPARTMENT_ID")
  ;

CREATE INDEX "EMP_NAME_IX" ON "EMPLOYEES" ("LAST_NAME", "FIRST_NAME")
  ;

CREATE INDEX "EMP_MANAGER_IX" ON "EMPLOYEES" ("MANAGER_ID")
  ;

CREATE INDEX "DEPT_LOCATION_IX" ON "DEPARTMENTS" ("LOCATION_ID")
  ;

CREATE INDEX "JHIST_DEPARTMENT_IX" ON "JOB_HISTORY" ("DEPARTMENT_ID")
  ;

CREATE INDEX "JHIST_JOB_IX" ON "JOB_HISTORY" ("JOB_ID")
  ;

CREATE INDEX "JHIST_EMPLOYEE_IX" ON "JOB_HISTORY" ("EMPLOYEE_ID")
  ;

CREATE INDEX "LOC_COUNTRY_IX" ON "LOCATIONS" ("COUNTRY_ID")
  ;

CREATE INDEX "EMP_JOB_IX" ON "EMPLOYEES" ("JOB_ID")
  ;

CREATE INDEX "LOC_CITY_IX" ON "LOCATIONS" ("CITY")
  ;

CREATE OR ALTER PROCEDURE "ADD_JOB_HISTORY" 
  (  p_emp_id          TYPE OF COLUMN job_history.employee_id
   , p_start_date      TYPE OF COLUMN job_history.start_date
   , p_end_date        TYPE OF COLUMN job_history.end_date
   , p_job_id          TYPE OF COLUMN job_history.job_id
   , p_department_id   TYPE OF COLUMN job_history.department_id
   )
AS
BEGIN
  INSERT INTO job_history (employee_id, start_date, end_date,
                           job_id, department_id)
    VALUES(:p_emp_id, :p_start_date, :p_end_date, :p_job_id, :p_department_id);
END ^

SET TERM ; ^


--------------------------------------------------------
--  DDL for Procedure SECURE_DML
--------------------------------------------------------


CREATE EXCEPTION CUSTOM_EXCEPTION 'error';

CREATE OR ALTER PROCEDURE "SECURE_DML" 
AS
BEGIN
  IF (UPPER( CAST (CURRENT_TIMESTAMP AS VARCHAR(32000) FORMAT 'HH24:MI')) NOT BETWEEN '08:00' AND '18:00'
        OR UPPER( CAST (CURRENT_TIMESTAMP AS VARCHAR(32000) FORMAT 'DY')) IN ('SAT', 'SUN')) THEN
	EXCEPTION CUSTOM_EXCEPTION (
		'You may only make changes during normal office hours');
END ^

SET TERM ; ^

CREATE OR ALTER TRIGGER "SECURE_EMPLOYEES" 
  BEFORE INSERT OR UPDATE OR DELETE ON employees

AS

 BEGIN
  EXECUTE PROCEDURE secure_dml;
 END ^

SET TERM ; ^

 END /*secure_employees*/;

CREATE OR ALTER TRIGGER "UPDATE_JOB_HISTORY" 
  AFTER UPDATE   ON employees


AS

 BEGIN
IF (NEW.job_id <> OLD.job_id OR NEW.department_id <> OLD.department_id) THEN
  EXECUTE PROCEDURE add_job_history(old.employee_id, old.hire_date, CURRENT_TIMESTAMP,
                  old.job_id, old.department_id);

 END;

ALTER TRIGGER "SECURE_EMPLOYEES" INACTIVE;

ALTER TRIGGER "UPDATE_JOB_HISTORY" ACTIVE;

