CREATE VIEW departments_hq_man (department_id, department_name, manager_id, location_id)
AS SELECT department_id, department_name, manager_id, location_id
   FROM hr.departments
   WHERE location_id = 1700;