SELECT REGEXP_SUBSTR('500 Oracle Parkway, Redwood Shores, CA', ',[^,]+,') FROM RDB$DATABASE;

SELECT REGEXP_SUBSTR('http://www.example.com/products', 'http://([[:alnum:]]+.{0,1}){3,4}/{0,1}') FROM RDB$DATABASE;

SELECT REGEXP_SUBSTR('1234567890', '(123)(4(56)(78))', 2, 1, 'i', 1) FROM RDB$DATABASE;

SELECT REGEXP_SUBSTR('my email http://www.example.com/products', 'http://([[:alnum:]]+.{0,1}){3,4}/{0,1}', 0, 1, '', 4) FROM RDB$DATABASE;

SELECT REGEXP_SUBSTR('abcd1234efgh5678', '([[:ALPHA:]]+[0-9]+)',1,5) FROM RDB$DATABASE;