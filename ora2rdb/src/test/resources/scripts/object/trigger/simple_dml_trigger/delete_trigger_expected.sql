-- Warning: this is a row trigger
create or alter trigger tr_turtles_bue
before delete
on turtles
begin
 RDB$TRACE_MSG('trigger on turtles is worked' , false);
end;