CREATE PROCEDURE P_While_Label
AS
  DECLARE done BOOLEAN = FALSE;
  DECLARE res VARCHAR(50) = '';
BEGIN
  loopA:
  WHILE ((NOT :done)) DO 
  BEGIN
    done = TRUE;
    res = 'Hello, world!';
  END /*loopA*/
END;