CREATE OR REPLACE PROCEDURE "GZVLG"."RPL$DEACTIVATE_RPL"
AS
  stmt varchar(2000);
cursor s is SELECT TRIGGER_NAME from USER_TRIGGERS where (TRIGGER_NAME like 'RPL$%');
BEGIN
FOR s_rec in s loop
    stmt := 'DROP TRIGGER ' || s_rec.trigger_name;
execute immediate stmt;
end loop;
select 1 from DUAL;
END;