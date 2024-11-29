create or replace trigger tr_turtles_bue
before insert on turtles
for each row
begin
    DBMS_OUTPUT.PUT_LINE('update turtles');
end;