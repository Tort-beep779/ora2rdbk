CREATE OR REPLACE TRIGGER t
  INSTEAD OF
    INSERT OR UPDATE OR DELETE
ON v -- v это  представление
BEGIN
    CASE
        WHEN INSERTING THEN
            DBMS_OUTPUT.PUT_LINE('Inserting');
        WHEN UPDATING THEN
            DBMS_OUTPUT.PUT_LINE('Updating ');
        WHEN DELETING THEN
            DBMS_OUTPUT.PUT_LINE('Deleting');
    END CASE;
END;