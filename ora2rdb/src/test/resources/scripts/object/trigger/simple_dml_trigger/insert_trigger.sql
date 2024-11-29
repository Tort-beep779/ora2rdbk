create or replace trigger tr_turtles_bue
before insert
on turtles
begin
 DBMS_OUTPUT.PUT_LINE('update turtles');
end;