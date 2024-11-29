create or replace trigger tr_turtles_bue
before update of essence
       on turtles
begin
 RDB$TRACE_MSG('trigger on turtles is worked' , false);
end;