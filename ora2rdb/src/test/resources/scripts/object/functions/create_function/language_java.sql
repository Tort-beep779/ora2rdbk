CREATE FUNCTION fDelete (
   file VARCHAR2) RETURN NUMBER
AS LANGUAGE JAVA
      NAME 'JDelete.delete (java.lang.String) return int';
