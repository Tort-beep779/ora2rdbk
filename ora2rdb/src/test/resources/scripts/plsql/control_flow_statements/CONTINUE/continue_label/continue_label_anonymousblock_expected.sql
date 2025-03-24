EXECUTE BLOCK
AS
  DECLARE x NUMERIC(34, 8) = 0;
BEGIN
  loop1:
  WHILE (TRUE) DO 
  BEGIN
    x = :x + 1;
    IF (:x < 3) THEN
      CONTINUE loop1;
    IF(:x = 5) THEN LEAVE;
  END 
END;