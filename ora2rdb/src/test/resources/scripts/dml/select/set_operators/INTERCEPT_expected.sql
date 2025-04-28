SELECT department_id, department_name
FROM   departments
WHERE  department_id <= 30
[-unconvertible INTERSECT]
SELECT department_id, department_name
FROM   departments
WHERE  department_id >= 20
ORDER BY 1;