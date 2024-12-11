CREATE FUNCTION fDelete (
    file VARCHAR) RETURNS NUMERIC
    SQL SECURITY DEFINER
    EXTERNAL NAME  'JDelete.delete (java.lang.String) return int'
    ENGINE JAVA;