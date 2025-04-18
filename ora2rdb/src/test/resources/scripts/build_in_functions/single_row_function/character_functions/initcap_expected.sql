CREATE FUNCTION INITCAP_CUSTOM (input_text VARCHAR(8191)) 
RETURNS VARCHAR(8191) 
AS
  DECLARE result VARCHAR(8191);
  DECLARE current_char CHAR(1);
  DECLARE prev_char_is_alnum BOOLEAN;
  DECLARE current_char_is_alnum BOOLEAN;
BEGIN
    result = '';
    prev_char_is_alnum = FALSE; 
    WHILE ( CHAR_LENGTH(input_text) > 0) DO
    BEGIN
        current_char = LEFT(input_text, 1);
        input_text = SUBSTRING(input_text FROM 2);
        current_char_is_alnum = current_char SIMILAR TO '[0-9A-Za-zА-Яа-яЁё]';
        IF (current_char_is_alnum) THEN
        BEGIN  
            IF (prev_char_is_alnum) THEN
                current_char = LOWER(current_char);
            ELSE 
                current_char = UPPER(current_char);  
            prev_char_is_alnum = TRUE;
        END
        ELSE 
            prev_char_is_alnum = FALSE;
        result = result || current_char;    
    END
    RETURN result;
END;

SELECT INITCAP_CUSTOM('hello world') FROM RDB$DATABASE;
SELECT INITCAP_CUSTOM('  6hello w6orld') FROM RDB$DATABASE;
SELECT INITCAP_CUSTOM('hELLO  _ _   wOOORLD   ') FROM RDB$DATABASE;
SELECT INITCAP_CUSTOM('привет, мир!') FROM RDB$DATABASE;