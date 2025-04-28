### [accessible_by_clause.sql](accessible_by_clause.sql)

ограничивает доступ к процедуре программными модулями, перечисленными в круглых скобках. 

Ожидамеый результат для теста 

    /*
    THERE WAS ACCESSIBLE BY OPERATOR , WHICH IS NOT SUPPORTED IN RED DATABASE
    */
    CREATE PROCEDURE COMBINE_AND_FORMAT_NAMES
    SQL SECURITY DEFINER
    AS
    BEGIN
    
    END;

-------------------------------------------------------------
## Права выполнения процедуры

### [AUTHID_current_user.sql](AUTHID_current_user.sql)

**AUTHID CURRENT_USER** определяет, что процедцра будет вызываться с правами вызывающего пользователя

Аналог в Ред База Данных

    SQL SECURITY INVOKER

### [AUTHID_DEFINER.sql](AUTHID_DEFINER.sql)

**AUTHID DEFINER** определяет, что процедцра будет вызываться с правами создателя

    SQL SECURITY DEFINER

### Важно 

По умолчанию процедура в ORACLE вызывается с правами создателя (DEFINER) , а в Ред База Данных
с правами вызывающего пользователя (INVOKER)

Соответственно, если атрибут **AUTHID** не указан, то при конвертации надо добавить **SQL SECURITY DEFINER**

-------------------------------------------------------------

### [EDITIONABLE_procedure_expected.sql](EDITIONABLE_procedure_expected.sql)

    [ EDITIONABLE | NONEDITIONABLE ]

Specifies whether the procedure is an editioned or noneditioned object
**Default:** EDITIONABLE.

-------------------------------------------------------------

### [sharing_declaration.sql](sharing_declaration.sql)

    SHARING = { METADATA | NONE }

* METADATA - A metadata link shares the metadata, but its data is unique to each container. This type of object is referred to as a metadata-linked application common object.

* NONE - The object is not shared and can only be accessed in the application root.

