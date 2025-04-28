/* Can not convert the select statement which select data from a nested table column*/
 SELECT t1.department_id, t2.* FROM hr_info t1, [-unconvertible TABLE(t1.people)] t2
    WHERE t2.department_id = t1.department_id;