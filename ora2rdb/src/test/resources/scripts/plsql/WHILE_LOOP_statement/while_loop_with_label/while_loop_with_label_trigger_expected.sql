CREATE OR ALTER TRIGGER T_While_Label
  AFTER INSERT
  ON students 
AS
  DECLARE done BOOLEAN = FALSE;
  DECLARE res  VARCHAR(50) = '';
BEGIN
  loopA:
  WHILE (NOT :done) DO 
  BEGIN
    done = TRUE;
    res = 'Hello, world!';
  END /*loopA*/
END /*T_While_Label*/;