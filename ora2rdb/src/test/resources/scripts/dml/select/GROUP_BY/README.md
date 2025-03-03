[Хорошая статься на эту тему](https://torofimofu.blogspot.com/2013/08/rollup-cube-groupping-sets.html)

### GROUP BY и HAVING

Предложение **GROUP BY** позволяет сгруппировать полученные в результате выполнения оператора SELECT строки

Необязательное предложение **HAVING** определяет дополнительные условия поиска (условия выборки строк таблицы/таблиц) для использования в GROUP BY. Предложение HAVING может использоваться только вместе с предложением GROUP BY.Предложение HAVING вместе с предложением WHERE, предложениями FIRST,SKIP, ORDER BY и ROWS сокращает количество отобранных строк в результирующем выходном наборе данных.Условие выборки в предложении HAVING может ссылаться на: Любой агрегированный столбец в списке выбора SELECT. Это наиболее широко используемый случай.

При конертации изменений нет (1 к 1)

### GROUP BY CUBE

Функция CUBE выполняет агрегирование данных по всем возможным группировкам для переданного ей списка столбцов

    SELECT
    owner,
    object_type,
    COUNT(*)
    FROM the_objects
    GROUP BY CUBE(object_type, owner);
    
    OWNER           OBJECT_TYPE             COUNT(*)
    --------------- --------------------- ----------
                                                 511
    SCOTT                                          6
    SYSTEM                                       505
    TYPE                           1
    SYSTEM          TYPE                           1
    VIEW                          12
    SYSTEM          VIEW                          12
    INDEX                        213
    SCOTT           INDEX                          2
    SYSTEM          INDEX                        211
    TABLE                        161
    SCOTT           TABLE                          4
    SYSTEM          TABLE                        157
    PACKAGE                        1
    SYSTEM          PACKAGE                        1
    SYNONYM                        8
    SYSTEM          SYNONYM                        8
    TRIGGER                        2
    SYSTEM          TRIGGER                        2
    SEQUENCE                      20
    SYSTEM          SEQUENCE                      20
    PROCEDURE                      1
    SYSTEM          PROCEDURE                      1
    PACKAGE BODY                   1
    SYSTEM          PACKAGE BODY                   1
    INDEX PARTITION               52
    SYSTEM          INDEX PARTITION               52
    TABLE PARTITION               39
    SYSTEM          TABLE PARTITION               39

### GROUP BY ROLLUP 

[примеры](https://torofimofu.blogspot.com/2013/08/rollup-cube-groupping-sets.html)

Используя ROLLUP в части GROUP BY предложения SELECT, мы, одновременно с агрегированием данных по столбцам списка GROUP BY, получаем итоговые (общие и промежуточные) количества. Пример:

    SELECT
    owner,
    COUNT(*) ownerobj#    -- сколько объектов у каждого владельца
    FROM the_objects
    GROUP BY ROLLUP(owner);
    
    OWNER            OWNEROBJ#
    --------------- ----------
    SCOTT                    6
    SYSTEM                 505
    511

Можно заменить двумя запросами

    -- запрос 1
    SELECT
    COUNT(*) total,                    -- сколько всего объектов
    COUNT(DISTINCT owner) owner#,      -- скольким владельцам они принадлежат
    COUNT(DISTINCT object_type) type#  -- к скольким разным типам они относятся
    FROM the_objects;
    
         TOTAL     OWNER#      TYPE#
    ---------- ---------- ----------
           511          2         12

    -- запрос 2
    SELECT
    owner,
    COUNT(*) ownerobj#    -- сколько объектов у каждого владельца
    FROM the_objects
    GROUP BY owner;
    
    OWNER            OWNEROBJ#
    --------------- ----------
    SYSTEM                 505
    SCOTT                    6

### GROUPING SETS

**GROUPING SETS** позволяет автору запроса явно перечислить интересующие его группировки (подмножества), по которым Oracle выполнит агрегирование данных.

Пусть мы хотим получить кол-ва объектов в разрезе владельцев и, отдельно, кол-ва объектов в разрезе типов объектов. Для этого, без использования GROUPING SETS, нам пришлось бы выполнить следующий запрос:

    SELECT owner, COUNT(*) FROM the_objects GROUP BY owner
    UNION
    SELECT object_type, COUNT(*) FROM the_objects GROUP BY object_type;

Используя GROUPING SETS

    -- запрос 13
    SELECT
    owner,
    object_type,
    COUNT(*)
    FROM the_objects
    GROUP BY GROUPING SETS ((object_type), (owner));
    
    OWNER           OBJECT_TYPE             COUNT(*)
    --------------- --------------------- ----------
                    INDEX PARTITION               52
                    SEQUENCE                      20
                    TABLE PARTITION               39
                    PROCEDURE                      1
                    PACKAGE                        1
                    PACKAGE BODY                   1
                    TRIGGER                        2
                    TABLE                        161
                    INDEX                        213
                    SYNONYM                        8
                    VIEW                          12
                    TYPE                           1
    SYSTEM                                       505
    SCOTT                                          6

