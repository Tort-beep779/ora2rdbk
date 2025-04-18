CREATE FUNCTION FDELETE (
   FILE VARCHAR2) RETURN NUMBER
AS LANGUAGE JAVA
      NAME 'JDelete.delete (java.lang.String) return int';
