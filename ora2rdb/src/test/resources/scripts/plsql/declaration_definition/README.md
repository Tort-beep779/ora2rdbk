### [deterministic_function_declaration.sql](deterministic_function_declaration.sql)

Необязательное предложение **DETERMINISTIC** указывает, что функция детерминированная. 

Детерминированные функции каждый 
раз возвращают один и тот же результат, если предоставлять им один и тот же набор входных значений. 

Недетерминированные функции 
могут возвращать каждый раз разные результаты, даже если предоставлять им один и тот же набор входных значений. 

Если для функции указано, что она является детерминированной, то такая функция не вычисляется заново,
если она уже была вычислена однажды с данным набором входных аргументов, 
а берет свои значенияиз кэша метаданных (если они там есть).

В РБД существует полный аналог

----------------------------------------------


### [nested_submodules.sql](nested_submodules.sql)

В РБД нельзя объявить подпроцедуру/подфункцию внутри подпроцедуры/подфункциы. 
То есть допустим только один уровень вложенности. 

**Предложение по конвертации : коммментировать все вложенные блоки**


----------------------------------------------

### [parallel_enable_function_definition.sql](parallel_enable_function_definition.sql)

**PARALLEL_ENABLE** — используется для оптимизации и позволяет функции выполняться
параллельно в случае, когда она вызывается из команды SELECT.

**Предложение по конвертации : удалять этот атрибут**

-----------------------------------------------

### [pipelined_function_defenition.sql](pipelined_function_defenition.sql)

[Сыылка на статью](https://newtechaudit.ru/pipelined-ili-konvejernaya-funkcziya/)

    create or replace function func_name(…) return тип_коллекция
    pipelined
    is
    begin
    … цикл …
    pipe row (элемент_коллекции);
    …
    end;

Пример использования pipelined функции 

    ----- Пример 1. Pipelined функции с объектами
    -- объект
    create or replace type t_person is object(
    id number,
    full_name varchar2(200 char)
    );
    /
    -- коллекция объектов
    create or replace type t_persons is table of t_person;
    /
    -- конвейерная функция
    create or replace function get_persons return t_persons
    pipelined
    is
    begin
    -- генерируем 10 строк
    for i in 1..10 loop
    -- возвращаем результат
    pipe row(t_person(i, 'full_name_'||i));
    end loop;
    end;
    /
    -- вызываем (<12)
    select * from table(get_persons());
    -- вызываем (12+)
    select * from get_persons();

**На данный момент нет очевидного решения как конвертировать такие функции**


---------------------------------------------

### [result_cache_function_definition.sql](result_cache_function_definition.sql)

RESULT_CACHE — указывает, что входные значения и результат вызова функции
должен быть сохранен в кэше результатов

**Предложение - при конвертации  удалять этот атрибут**


