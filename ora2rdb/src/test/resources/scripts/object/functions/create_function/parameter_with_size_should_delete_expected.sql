CREATE OR ALTER FUNCTION degree(value_in  NUMERIC)
    RETURNS NUMERIC
    SQL SECURITY DEFINER
    AS  DECLARE res NUMERIC(11,2);
BEGIN
      res = :value_in * :value_in;
RETURN(:res);
END;