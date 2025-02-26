CREATE PROCEDURE P_Grade_meaning2 (degree INTEGER)
RETURNS (res CHAR)
AS
  DECLARE pass BOOLEAN = FALSE;
BEGIN
    res = '';
    IF (:degree > 10) THEN
    BEGIN
      res = 'Good';
      pass = TRUE;
    END
    ELSE
    BEGIN
      res = 'Low';
      pass = FALSE;
    END
END;