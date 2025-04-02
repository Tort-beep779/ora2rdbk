CREATE FUNCTION TRANSLATE_CUSTOM (str1 VARCHAR(32765), from_st VARCHAR(32765), to_st VARCHAR(32765)) 
RETURNS VARCHAR(32765) 
AS
  DECLARE result VARCHAR(32765) = '';
  DECLARE current_char CHAR(1);
  DECLARE i INTEGER = 0;
  DECLARE pos INTEGER = 0;
BEGIN
  IF (str1||'R' = 'R' OR from_st||'R' = 'R' OR to_st||'R' = 'R') THEN
    RETURN NULL;
  IF (str1 = NULL OR from_st = NULL OR to_st = NULL) THEN
    RETURN NULL;
  i = 1;
  WHILE (i <= CHAR_LENGTH(str1)) DO
  BEGIN
    current_char = SUBSTRING(str1 FROM i FOR 1);
    pos = POSITION(current_char IN from_st);
    IF ( pos > 0 ) THEN
      IF (pos <= CHAR_LENGTH(to_st)) THEN
        result = result || SUBSTRING(to_st FROM pos FOR 1);
    ELSE
      result = result || current_char;
    i = i + 1;
  END  
  RETURN result;
END;


SELECT TRANSLATE_CUSTOM('1234efg', '1234', 'xyz') FROM RDB$DATABASE;

SELECT TRANSLATE_CUSTOM('ab2cde1fg', '1234', 'xyzf') FROM RDB$DATABASE;

SELECT TRANSLATE_CUSTOM('44prnf32', '234', 'xyzf') FROM RDB$DATABASE;