create or replace trigger tr_turtles_bue
before delete
on turtles
begin
 DBMS_OUTPUT.PUT_LINE('update turtles');
end;