CREATE FUNCTION F_While_Label
RETURNS VARCHAR(32765)
AS
  DECLARE done BOOLEAN = FALSE;
  DECLARE res VARCHAR(50) = '';
BEGIN
  loopA:
  WHILE (NOT :done) DO 
  BEGIN
    done = TRUE;
    res = 'Hello, world!';
  END /*loopA*/
  RETURN res;
END;