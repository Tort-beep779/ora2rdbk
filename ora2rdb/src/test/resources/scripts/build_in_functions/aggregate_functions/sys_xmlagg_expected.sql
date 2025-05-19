SELECT [-unconvertible SYS_XMLAGG([-unconvertible SYS_XMLGEN(last_name)])] XMLAGG
   FROM employees
   WHERE last_name LIKE 'R%';