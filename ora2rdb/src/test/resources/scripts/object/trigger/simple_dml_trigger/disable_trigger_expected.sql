CREATE  TRIGGER "TR_TURTLES_BUE"
    after delete
    on t_2  AS begin
	RDB$TRACE_MSG(('update turtles'),  false);
end;

ALTER TRIGGER "TR_TURTLES_BUE" INACTIVE;