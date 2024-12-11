CREATE OR ALTER FUNCTION fDelete (
    file  VARCHAR) RETURNS NUMERIC
    EXTERNAL NAME  'JDelete.delete (java.lang.String) return int'
    ENGINE JAVA;