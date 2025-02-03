/* Процедура */
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

/* Функция */
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

/* Пакет */
CREATE OR ALTER PACKAGE Pack_While_Label
AS 
BEGIN 
   FUNCTION PF_While_Label
   RETURNS VARCHAR(32765);  
   PROCEDURE PP_While_Label;  
END /*PACK_WHILE_LABEL*/;

/* Тело пакета */
RECREATE PACKAGE BODY Pack_While_Label
AS 
BEGIN 
   FUNCTION PF_While_Label
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
   END  

   PROCEDURE PP_While_Label
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
   END  
END /*PACK_WHILE_LABEL*/;

/* Триггер DML */
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

/* Анонимный блок */
EXECUTE BLOCK 
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
END;