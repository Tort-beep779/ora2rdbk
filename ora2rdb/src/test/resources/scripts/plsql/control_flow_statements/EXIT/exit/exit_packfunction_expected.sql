CREATE PACKAGE PackF_Exit
SQL SECURITY DEFINER
AS BEGIN
   FUNCTION PF_Exit 
   RETURNS VARCHAR(32765);
END;

CREATE PACKAGE BODY PackF_Exit
AS BEGIN
   FUNCTION PF_Exit
   RETURNS VARCHAR(32765)
   AS
     DECLARE i_FOR1 INTEGER;
     DECLARE bound_i_FOR1 INTEGER;
   BEGIN
     i_FOR1 = 1;
     bound_i_FOR1 = 3;
     WHILE (i_FOR1 <= bound_i_FOR1) DO
     BEGIN 
       if (i_FOR1 = 3) then 
         LEAVE;
       i_FOR1 = i_FOR1 + 1;
     END
     i_FOR1 = bound_i_FOR1;
     RETURN '';
   END
END;