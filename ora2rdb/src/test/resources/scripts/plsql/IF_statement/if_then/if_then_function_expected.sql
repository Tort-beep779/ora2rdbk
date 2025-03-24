CREATE FUNCTION F_Grade_meaning1 (degree INTEGER)
RETURNS VARCHAR(32765)
AS
   DECLARE pass BOOLEAN = FALSE;
   DECLARE res  CHAR(15) = '';
BEGIN
    IF (:degree > 10) THEN
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
    RETURN res;
END;