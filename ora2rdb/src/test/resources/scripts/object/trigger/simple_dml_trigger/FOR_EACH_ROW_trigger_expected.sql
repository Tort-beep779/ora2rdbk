create or alter trigger tr_turtles_bue
before insert on turtles
as begin
    RDB$TRACE_MSG('trigger on turtles is worked' , false);
end;
-- В ред база всегда работает для каждой строки (row trigger)
-- если в триггере не указан for each row - выдается предупреждение