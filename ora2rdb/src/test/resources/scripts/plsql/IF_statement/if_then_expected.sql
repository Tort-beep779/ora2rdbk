/* Процедура */
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

/* Функция */
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

/* Пакет */
CREATE OR ALTER PACKAGE Pack_Grade_meaning1
AS 
BEGIN 
   FUNCTION PF_Grade_meaning1 (degree INTEGER)
   RETURNS VARCHAR(32765);  
   PROCEDURE PP_Grade_meaning1 (degree INTEGER)
   RETURNS (res CHAR);
END /*Pack_Grade_meaning1*/;

/* Тело пакета */
RECREATE PACKAGE BODY Pack_Grade_meaning1
AS 
BEGIN 
   FUNCTION PF_Grade_meaning1 (degree INTEGER)
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
   END  

   PROCEDURE PP_Grade_meaning1 (degree INTEGER)
   RETURNS (res CHAR)
   AS
      DECLARE pass BOOLEAN = TRUE;
   BEGIN
       res = '';
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
   END  
END /*Pack_Grade_meaning1*/;

/* Триггер DML */
CREATE OR ALTER TRIGGER T_Grade_meaning1
  AFTER INSERT
  ON students
AS
    DECLARE degree INTEGER;
    DECLARE pass CHAR(1) = 'F';
    DECLARE res  CHAR(15) = '';
BEGIN
   degree = NEW.mark;
   IF (:degree > 10) THEN
   BEGIN
     res = 'Good';
     pass = 'T';
   END
   IF ((:degree < 10) AND (:degree >=5)) THEN
   BEGIN
      res = 'Low';
      pass = 'F';
   END    
   IF (:degree < 5) THEN
      res = 'Too low';  
END /*T_Grade_meaning1*/;

/* Анонимный блок */
EXECUTE BLOCK 
AS
   DECLARE pass BOOLEAN = FALSE;
   DECLARE res  CHAR(15) = '';
   DECLARE degree INTEGER = 14;
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
END;

