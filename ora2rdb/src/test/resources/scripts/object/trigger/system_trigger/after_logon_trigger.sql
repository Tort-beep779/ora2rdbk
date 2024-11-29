CREATE TRIGGER logon_trigger
AFTER LOGON ON DATABASE
BEGIN
   DBMS_OUTPUT.PUT_LINE('User logged into the database.');
END logon_trigger;