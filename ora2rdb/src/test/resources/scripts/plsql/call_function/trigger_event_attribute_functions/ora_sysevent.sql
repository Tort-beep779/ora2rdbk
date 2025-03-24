CREATE TRIGGER TRG_DDL
AFTER DDL ON SCHEMA
DECLARE
    system_event VARCHAR2(20);
BEGIN
    system_event := ora_sysevent;
END;