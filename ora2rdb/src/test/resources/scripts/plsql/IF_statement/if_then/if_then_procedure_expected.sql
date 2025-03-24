CREATE PROCEDURE P_Grade_meaning1 (degree INTEGER)
RETURNS (res CHAR)
AS
  DECLARE pass BOOLEAN = FALSE;
BEGIN
    res = '';
    IF (:degree >= 10) THEN
    BEGIN
      res = 'Good';
      pass = TRUE;
    END     
    IF ((:degree < 10) AND (:degree >=5)) THEN
    BEGIN
      res = 'Low';
      pass = FALSE;
    END     
    IF (:degree < 5) THEN
      res = 'Too low';
END;