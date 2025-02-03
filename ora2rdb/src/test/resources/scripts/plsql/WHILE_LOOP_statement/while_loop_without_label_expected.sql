/* Процедура */
CREATE PROCEDURE P_While
AS
  DECLARE done BOOLEAN = FALSE;
  DECLARE res VARCHAR(50) = '';
BEGIN
  WHILE (:done) DO 
    res = 'This line does not print.';
  WHILE (NOT :done) DO 
  BEGIN
    done = TRUE;
    res = 'Hello, world!';
  END   
  WHILE (NOT :done) DO 
    res = 'This line does not print.';   
END;

/* Функция */
CREATE FUNCTION F_While
RETURNS VARCHAR(32765)
AS
  DECLARE done BOOLEAN = FALSE;
  DECLARE res VARCHAR(50) = '';
BEGIN
  WHILE (:done) DO 
    res = 'This line does not print.';  
  WHILE (NOT :done) DO 
  BEGIN
    done = TRUE;
    res = 'Hello, world!';
  END   
  WHILE (NOT :done) DO 
    res = 'This line does not print.';
  RETURN res;
END;

/* Пакет */
CREATE OR ALTER PACKAGE Pack_While
AS 
BEGIN 
   FUNCTION PF_While
   RETURNS VARCHAR(32765);  
   PROCEDURE PP_While;  
END /*PACK_WHILE*/;

/* Тело пакета */
RECREATE PACKAGE BODY Pack_While
AS 
BEGIN 
   FUNCTION PF_While
   RETURNS VARCHAR(32765)
   AS
     DECLARE done BOOLEAN = FALSE;
     DECLARE res VARCHAR(50) = '';
   BEGIN
     WHILE (:done) DO 
       res = 'This line does not print.';     
     WHILE (NOT :done) DO 
     BEGIN
       done = TRUE;
       res = 'Hello, world!';
     END      
     WHILE (NOT :done) DO 
       res = 'This line does not print.';      
     RETURN res;
   END  

   PROCEDURE PP_While
   AS
     DECLARE done BOOLEAN = FALSE;
     DECLARE res VARCHAR(50) = '';
   BEGIN
     WHILE (:done) DO 
       res = 'This line does not print.';
     WHILE (NOT :done) DO 
     BEGIN
       done = TRUE;
       res = 'Hello, world!';
     END
     WHILE (NOT :done) DO 
       res = 'This line does not print.';    
   END  
END /*PACK_WHILE*/;

/* Триггер DML */
CREATE OR ALTER TRIGGER T_While
  AFTER INSERT
  ON students
AS
  DECLARE done BOOLEAN = FALSE;
  DECLARE res  VARCHAR(50) = '';
BEGIN
  WHILE (:done) DO 
    res = 'This line does not print.';  
  WHILE (NOT :done) DO 
  BEGIN
    done = TRUE;
    res = 'Hello, world!';
  END   
  WHILE (NOT :done) DO 
    res = 'This line does not print.';
 END /*T_While*/;

/* Анонимный блок */
EXECUTE BLOCK 
AS
  DECLARE done BOOLEAN = FALSE;
  DECLARE res  VARCHAR(50) = '';
BEGIN
  WHILE (:done) DO 
    res = 'This line does not print.';  
  WHILE (NOT :done) DO 
  BEGIN
    done = TRUE;
    res = 'Hello, world!';
  END   
  WHILE (NOT :done) DO 
    res = 'This line does not print.';  
END;
