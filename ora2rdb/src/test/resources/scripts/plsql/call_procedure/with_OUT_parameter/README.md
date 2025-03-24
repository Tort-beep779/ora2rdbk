В тесте используется процедура 
    
    -- Oracle
    CREATE PROCEDURE PROCEDURE_NAME(out_parameter OUT VARCHAR2)
    IS
    BEGIN
        NULL;
    END;
    
    -- Ред База Данных
    CREATE PROCEDURE PROCEDURE_NAME(out_parameter  VARCHAR(32765))
      RETURNS( OUT_PARAMETER_OUT VARCHAR(32765))
    AS
    BEGIN
        OUT_PARAMETER_OUT = OUT_PARAMETER;
        SUSPEND;
    END;