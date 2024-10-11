.. _sec:dml:

Преобразование DML операций 
============================

SELECT
------------

.. code-block::
    :redlines:  2,3,5,7,12,13,16,18,19,27,28,29
    :greenlines: 1, 4, 6, 8, 9, 10, 11, 14, 15, 17, 20, 21, 22, 23, 24, 25, 26, 30
    :caption: Oracle
    
    [WITH { <CTE>  
           | <промежуточное аналитическое представление>
           | <объявление процедуры/функции> }
           [, { <CTE> 
              | <промежуточное аналитическое представление> } ] ]
    SELECT 
       [ <подсказка> ] 
       [ { { DISTINCT | UNIQUE } | ALL } ] 
       <список выходных полей>
    FROM <источники>
    [ WHERE <условие выборки> ]
    [ CONNECT BY [ NOCYCLE ] <условие> [ START WITH <условие> ]
    | START WITH <условие> CONNECT BY [ NOCYCLE ] <условие> ]
    [ GROUP BY <список группирования>
        [ HAVING <условие выборки> ] ]
    [ MODEL ... ]
    [ UNION [ALL] <другой Select-запрос> ]
    [ INTERSECT  <другой Select-запрос> ]
    [ MINUS <другой Select-запрос> ]
    [ ORDER [ SIBLINGS ] BY <выражение для порядка выборки> ] 
    [ OFFSET <число строк> { ROW | ROWS } ]
    [ FETCH { FIRST | NEXT } [ { <число строк> | <процент> PERCENT } ]
            { ROW | ROWS } { ONLY | WITH TIES } ]
    [ FOR UPDATE [ OF [[<схема>.] {<таблица>|<представление>}.] <столбец>
                   [, [[<схема>.] {<таблица>|<представление>}.] <столбец> ]...
                 ]
      [ { NOWAIT | WAIT <число> 
        |  SKIP LOCKED }
      ]
    ];


Простой select запрос
^^^^^^^^^^^^^^^^^^^^^^^

.. list-table::
      :class: borderless
      
      * - :ess:`Oracle`
          
          .. code-block::
             :redlines:  4,6,7,8,9,10,11,12,15,16
             :greenlines: 1,2,3,5,13,14,17
             
             SELECT 
                 <выходное поле> [, <выходное поле>]
             FROM { 
                    { { { ONLY (<ссылка на таблицу>) 
                        | <ссылка на таблицу> }
                      [ <для ретроспективных запросов> ]
                      [ PIVOT ... | UNPIVOT ... 
                      | MATCH_RECOGNIZE (...) ] 
                      }
                    | CONTAINERS(...)
                    | SHARDS (...)
                    }
                    [ <алиас> ] 
                  | <соединение JOIN> 
                  | ( <соединение JOIN> ) 
                  | ANALYTIC VIEW ... } 
                  [ , ... ];
 	                                                        
        - :ess:`Rdb`
        
          .. code-block:: 
             :greenlines: 1,2,3,5,13,14,17
             
             SELECT 
                <выходное поле> [, <выходное поле>]
             FROM {
             
                    <ссылка на таблицу>
                 
                 





                    [[AS] <алиас>]
                  | <соединение JOIN> }


                  [ , ... ];


Ссылка на таблицу
""""""""""""""""""""


.. list-table::
      :class: borderless
      
      * - :ess:`Oracle`
          
          .. code-block::
             :redlines: 4,5,6,8,9
             :greenlines: 1,2,3,7
             
               <имя СТЕ>
             | [<схема>.] <имя таблицы> [SAMPLE ...]
             | [<схема>.] <имя представления> [SAMPLE ...]
             | [<схема>.] <имя иерархии> [SAMPLE ...]
             | [<схема>.] <имя анал.представления> 
               [ HIERARCHIES(...) ] [SAMPLE ...]
             | [ LATERAL ] ( <оператор select> 
                            [<ограничение запроса>] )
             | <table_collection_expression>
             
 	                                                        
        - :ess:`Rdb`
        
          .. code-block:: 
             :greenlines: 1,2,3,7
             
               <имя CTE> 
             | <имя таблицы> 
             | <имя представления>
             
             
             
             | [ LATERAL ] (<оператор select>) 
               
                                                        .


JOINs
^^^^^^

.. code-block::
    :redlines:  6
    :greenlines: 1, 2, 3, 4, 5, 7
    :caption: Oracle
    
    <соединение JOIN> ::= <ссылка на таблицу>
                          { <внутреннее соединение> 
                          | <внешнее соединение> 
                          | <перекрестное соединение> 
                          | <естественное соединение>
                          | { CROSS | OUTER } APPLY { <ссылка на таблицу> | collection_expression }
                          }...


Внутреннее соединение
""""""""""""""""""""""

.. list-table::
      :class: borderless
      
      * - :ess:`Oracle`
          
          .. code-block::
             :greenlines: 1,2,3
             
             [ INNER ] JOIN <ссылка на таблицу>
             { ON <условие join> 
             | USING (<список столбцов>) }
                                                                    
        - :ess:`Rdb`
        
          .. code-block:: 
             :greenlines: 1,2,3
             
             [ INNER ] JOIN <ссылка на таблицу> 
             { ON <условие join> 
             | USING (<список столбцов>) }


Внешнее соединение
""""""""""""""""""""""

.. list-table::
      :class: borderless
      
      * - :ess:`Oracle`
          
          .. code-block::
             :redlines: 1,4
             :greenlines: 2,3,5,6
             
             [ PARTITION BY ... ] 
             {LEFT | RIGHT | FULL} [ OUTER ]
             JOIN <ссылка на таблицу> 
             [ PARTITION BY ... ]
             [ ON <условие join>
             | USING (<список столбцов>) ]
	                                                        
        - :ess:`Rdb`
        
          .. code-block:: 
             :greenlines: 2,3,5,6
             
                                                        .
             {LEFT | RIGHT | FULL} [OUTER] 
             JOIN <ссылка на таблицу> 
             
             { ON <условие join> 
             | USING (<список столбцов>) }


Перекрестное соединение
""""""""""""""""""""""""

.. list-table::
      :class: borderless
      
      * - :ess:`Oracle`
          
          .. code-block::
             :greenlines: 1
             
             CROSS JOIN <ссылка на таблицу>
                                                            
        - :ess:`Rdb`
        
          .. code-block:: 
             :greenlines: 1
             
             CROSS JOIN <ссылка на таблицу>


Естественное соединение
""""""""""""""""""""""""""""""""""""

.. list-table::
      :class: borderless
      
      * - :ess:`Oracle`
          
          .. code-block::
             :redlines: 3,7,8,9
             :greenlines: 1,2,4,5,6,10
             
             { NATURAL [ INNER ]  
               JOIN <ссылка на таблицу>
             | [ PARTITION BY ... ] 
               NATURAL
               { FULL | LEFT | RIGHT } [ OUTER ]
               JOIN <ссылка на таблицу> 
               [ PARTITION BY ... ]
               [ ON <условие join>
               | USING (<список столбцов>) ]
             }
             
                  
        - :ess:`Rdb`
        
          .. code-block:: 
             :greenlines: 1,2,3,4,5,6,10
             
             { NATURAL [ INNER ] 
               JOIN <ссылка на таблицу>
             | 
               NATURAL 
               { FULL | LEFT | RIGHT } [ OUTER ] 
               JOIN <ссылка на таблицу>



             }


WITH
^^^^^^

.. list-table::
      :class: borderless
      
      * - :ess:`Oracle`
          
          .. code-block::
             :redlines: 3,4
             :greenlines: 1,2,5,6
             
             WITH <имя CTE> ([<список столбцов CTE>]) 
               AS (<SELECT-запрос>) 
               [SEARCH ...] 
               [CYCLE ...]
               [, <имя CTE> ...]
             SELECT ...
                  
        - :ess:`Rdb`
        
          .. code-block:: 
             :greenlines: 1,2,3,6

             WITH <имя CTE> ([<список столбцов CTE>]) 
               AS (<SELECT-запрос>) 
               [, <имя CTE> ...]


             SELECT ...
              

DISTINCT | UNIQUE, ALL
^^^^^^^^^^^^^^^^^^^^^^^

.. list-table::
      :class: borderless
      
      * - :ess:`Oracle`
          
          .. code-block::
             :greenlines: 1,2,3,4,5
             
             SELECT 
                [ {DISTINCT | UNIQUE} | ALL ]
                <выходное поле> [, <выходное поле>]
             FROM
                <источники>;
                  
        - :ess:`Rdb`
        
          .. code-block:: 
             :greenlines: 1,2,3,4,5

             SELECT 
               [DISTINCT | ALL]
               <выходное поле> [, <выходное поле>]
             FROM
               <источники>;



WHERE
^^^^^^^^^^^

.. list-table::
      :class: borderless
      
      * - :ess:`Oracle`
          
          .. code-block::
             :greenlines: 1,2,3,4,5
             
             SELECT 
                <выходное поле> [, <выходное поле>]
             FROM <источники>
             WHERE <условие выборки> ;
                  
        - :ess:`Rdb`
        
          .. code-block:: 
             :greenlines: 1,2,3,4,5

             SELECT 
               <выходное поле> [, <выходное поле>]
             FROM <источники>
             WHERE <условие выборки> ;


GROUP BY
^^^^^^^^^^

.. list-table::
      :class: borderless
      
      * - :ess:`Oracle`
          
          .. code-block::
             :redlines: 5,6
             :greenlines: 1,2,3,4,7,8,9
             
             SELECT 
                <выходное поле> [, <выходное поле>]
             FROM <источники>
             GROUP BY { <выражение>
                      | { ROLLUP | CUBE } (...)
                      | GROUPING SETS(...)
                      }
                      [, ...  ]
               [ HAVING <условие выборки> ] ;
                  
        - :ess:`Rdb`
        
          .. code-block:: 
             :greenlines: 1,2,3,4,9

             SELECT 
               <выходное поле> [, <выходное поле>]
             FROM <источники>
             GROUP BY <выражение> [, <выражение> ...]
               
               
               
               
               [ HAVING <условие выборки> ] ;


UNION
^^^^^^^

.. list-table::
      :class: borderless
      
      * - :ess:`Oracle`
          
          .. code-block::
             :redlines: 5,6
             :greenlines: 1,2,3,4,7,8,9
             
             SELECT 
                <выходное поле> [, <выходное поле>]
             FROM <источники>
             UNION [ALL] <SELECT-запрос> ;
                  
        - :ess:`Rdb`
        
          .. code-block:: 
             :greenlines: 1,2,3,4,9

             SELECT 
               <выходное поле> [, <выходное поле>]
             FROM <источники>
             UNION [DISTINCT | ALL] <SELECT-запрос> ;




ORDER BY
^^^^^^^^^^^

.. list-table::
      :class: borderless
      
      * - :ess:`Oracle`
          
          .. code-block::
             :greenlines: 1,2,3,4,5,6,7,8
             
             SELECT 
                <выходное поле> [, <выходное поле>]
             FROM <источники>
             ORDER [ SIBLINGS ] BY 
               {<имя/алиас столбца>|<позиция>|<выражение>}
               [ ASC | DESC ]
               [ NULLS FIRST | NULLS LAST ]
               [, ... ];
                  
        - :ess:`Rdb`
        
          .. code-block:: 
             :greenlines: 1,2,3,4,5,6,7,8

             SELECT 
               <выходное поле> [, <выходное поле>]
             FROM <источники>
             ORDER BY 
               {<имя/алиас столбца>|<позиция>|<выражение>}
               [ ASC[ENDING] | DESC[ENDING] ]
               [ NULLS FIRST | NULLS LAST ]
               [, ... ];



OFFSET, FETCH
^^^^^^^^^^^^^^

.. list-table::
      :class: borderless
      
      * - :ess:`Oracle`
          
          .. code-block::
             :redlines: 7,9
             :greenlines: 1,2,3,4,5,6,8
             
             SELECT 
                <выходное поле> [, <выходное поле>]
             FROM <источники>
             OFFSET <число строк> { ROW | ROWS } 
             FETCH { FIRST | NEXT } 
                [ { <число строк> 
                  | <процент> PERCENT } ]
                { ROW | ROWS } { ONLY 
                               | WITH TIES };
                  
        - :ess:`Rdb`
        
          .. code-block:: 
             :greenlines: 1,2,3,4,5,6,7,8

             SELECT 
               <выходное поле> [, <выходное поле>]
             FROM <источники>
             OFFSET <число строк> {ROW | ROWS}
             FETCH {FIRST | NEXT} 
                [<число строк>] 
                
                {ROW | ROWS} ONLY;
                                                        .


FOR UPDATE
^^^^^^^^^^^^

.. list-table::
      :class: borderless
      
      * - :ess:`Oracle`
          
          .. code-block::
             :redlines: 7,8
             :greenlines: 1,2,3,4,5,6
             
             SELECT 
                <выходное поле> [, <выходное поле>]
             FROM <источники>
             FOR UPDATE 
             [ OF [[<схема>.]{<табл.>|<view>}.] <столбец>
               [, ... ]... ]
             [ { NOWAIT | WAIT <число> 
               | SKIP LOCKED } ];
                  
        - :ess:`Rdb`
        
          .. code-block:: 
             :greenlines: 1,2,3,4,5,6

             SELECT 
               <выходное поле> [, <выходное поле>]
             FROM <источники>
             FOR UPDATE 
             [ OF <столбец> 
               [, <столбец>]...]
                                     
                                                        .



INSERT
-------------

.. code-block::
    :redlines: 2,4
    :greenlines: 1,3
    :caption: Oracle
    
    INSERT 
    [<подсказка>]
    { <вставка в одну таблицу>
    | <вставка в несколько таблиц> } ;


Вставка в одну таблицу
^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. list-table::
      :class: borderless
      
      * - :ess:`Oracle`
          
          .. code-block::
             :redlines: 10
             :greenlines: 1,2,3,4,5,6,7,8,9
             
             INSERT INTO 
             <выражение для целевой таблицы> [<алиас>]
             [ (<список столбцов>) ]
             { VALUES ({<выражение>|DEFAULT}
                      [, {<выражение>|DEFAULT}]...)
               [{RETURN|RETURNING } <список столбцов>
                  INTO <список переменных> ]
             | <SELECT-запрос> 
             } 
             [ LOG ERRORS ... ];
                  
        - :ess:`Rdb`
        
          .. code-block:: 
             :greenlines: 1,2,3,4,5,6,7,8,9
             
             INSERT INTO 
             <выражение для целевой таблицы>
             [ (<список столбцов>) ]
             { VALUES ({<выражение>|DEFAULT}
                       [, {<выражение>|DEFAULT}]...) 
               [RETURNING <список столбцов>
                 [INTO <список переменных>]]  
             | <SELECT-запрос> 
             };
                                                        .


Выражение для целевой таблицы
""""""""""""""""""""""""""""""

.. list-table::
      :class: borderless
      
      * - :ess:`Oracle`
          
          .. code-block::
             :redlines: 2,3,4,5
             :greenlines: 1,6
             
             { [<схема>.] <таблица>|<представление>
             | ( <SELECT-запрос> 
                 [ WITH {READ ONLY|CHECK OPTION} 
                   [CONSTRAINT <ограничение>] ] )
             | <table_collection_expression>
             }
                  
        - :ess:`Rdb`
        
          .. code-block:: 
             :greenlines: 1
             
             <таблица>|<представление>




                                                        .



UPDATE
-------

.. code-block::
    :redlines: 2,4,9,10,11,16
    :greenlines: 1,3,5,6,7,8,12,13,14,15
    :caption: Oracle
    
    UPDATE 
    [<подсказка>]
    { <выражение для целевой таблицы>
    | ONLY (<выражение для целевой таблицы>)
    } [ <алиас> ]
    SET
      { <имя столбца> = { <выражение> | (<select-запрос>) | DEFAULT } 
        [, <имя столбца> = { <выражение> | (<select-запрос>) | DEFAULT } ... ]
      | (<имя столбца> [, <имя столбца> ]...) = (<select-запрос>)  
        [, (<имя столбца> [, <имя столбца> ]...) = (<select-запрос>)  ... ]
      | VALUE (<алиас>) = { <выражение> | (<select-запрос>) }
      }
    [ WHERE <условие> ]
    [ { RETURN | RETURNING } <список столбцов> ... 
        INTO <список переменных> ]
    [ LOG ERRORS ... ] ;    


Операция обновления
""""""""""""""""""""""""""""""""

.. list-table::
      :class: borderless
      
      * - :ess:`Oracle`
          
          .. code-block::
             :greenlines: 1,2,3,4,5,6,7,8,9
             
             UPDATE 
             <выражение для целевой таблицы> 
             [<алиас>]
             SET
                <имя столбца> = <новое значение>
                [, <имя столбца> = <новое значение> ... ]
             [WHERE <условие> ]
             [{RETURN | RETURNING} <список столбцов> ...
               INTO <список переменных>];
                  
        - :ess:`Rdb`
        
          .. code-block:: 
             :greenlines: 1,2,3,4,5,6,7,8,9
             
             UPDATE  
             <выражение для целевой таблицы>
             [[AS] <алиас>]
             SET 
                <имя столбца> = <новое значение> 
                [, <имя столбца> = <новое значение>... ]
             [WHERE <условие> ]
             [RETURNING <список столбцов> 
               [INTO <список переменных>]]



DELETE
--------

.. list-table::
      :class: borderless
      
      * - :ess:`Oracle`
          
          .. code-block::
             :redlines: 2,5,10
             :greenlines: 1,3,4,6,7,8,9
             
             DELETE 
             [<подсказка>]
             [ FROM ]
             { <выражение для целевой таблицы>
             | ONLY (<выражение для целевой таблицы>)
             } [ <алиас> ]
             [ WHERE <условие> ]
             [ RETURNING <список столбцов> 
                [INTO <список переменных>] ]
             [ LOG ERRORS ... ];

                  
        - :ess:`Rdb`
        
          .. code-block:: 
             :greenlines: 1,3,4,6,7,8,9
             
             DELETE 
             
             FROM 
             <выражение для целевой таблицы> 

             [[AS] <алиас>]             
             [WHERE <условие поиска> ]
             [RETURNING {<список столбцов>} 
               [INTO <переменные>]];
                                                         .


MERGE
--------

.. list-table::
      :class: borderless
      
      * - :ess:`Oracle`
          
          .. code-block::
             :redlines: 2,11
             :greenlines: 1,3,4,5,6,7,8,9,10
             
             MERGE 
             [<подсказка>]
             INTO [<схема>.] {<таблица>|<представление>} 
             [<алиас>]
             USING {[<схема>.]{<таблица>|<представление>}
                   |(<select-запрос>)
                   } [ алиас ]
             ON (<условие соединения>)
             [ WHEN MATCHED ... ]
             [ WHEN NOT MATCHED ... ]
             [ LOG ERRORS ... ] ;

                  
        - :ess:`Rdb`
        
          .. code-block:: 
             :greenlines: 1,2,3,4,5,6,7,8,9,10
             
             MERGE 
             
             INTO {<таблица>|<представление>} 
             [[AS] <алиас>]
   	         USING { <таблица>|<представление>
                   | (<select-запрос>)
                   } [[AS] <алиас>]
   	         ON <условие соединения>
   	         [ WHEN MATCHED ... ]
             [ WHEN NOT MATCHED ... ] ;
                                                        .


WHEN MATCHED
^^^^^^^^^^^^^^^

.. list-table::
      :class: borderless
      
      * - :ess:`Oracle`
          
          .. code-block::
             :greenlines: 1,2,3,4,5,6,7,8,9,10
             
             MERGE 
             INTO [<схема>.] {<таблица>|<представление>} 
             USING ...
             ON (<условие соединения>)
             WHEN MATCHED 
               THEN UPDATE SET <список назначений> 
               [ WHERE <доп.условие> ]
               [ DELETE WHERE <условие> ] ;

                  
        - :ess:`Rdb`
        
          .. code-block:: 
             :greenlines: 1,2,3,4,5,6,7,8,9,10
             
             MERGE              
             INTO {<таблица>|<представление>} 
   	         USING ...
   	         ON <условие соединения>
   	         WHEN MATCHED [ AND <доп.условие> ]
               THEN { UPDATE SET <список назначений> 

                    | DELETE } ;


WHEN NOT MATCHED
^^^^^^^^^^^^^^^^^^

.. list-table::
      :class: borderless
      
      * - :ess:`Oracle`
          
          .. code-block::
             :greenlines: 1,2,3,4,5,6,7,8,9,10
             
             MERGE 
             INTO [<схема>.] {<таблица>|<представление>} 
             USING ...
             ON (<условие соединения>)
             WHEN NOT MATCHED

               THEN INSERT [ (<список столбцов>) ]
               VALUES (<значения>)
               [ WHERE <доп.условие> ];
             

                  
        - :ess:`Rdb`
        
          .. code-block:: 
             :greenlines: 1,2,3,4,5,6,7,8,9,10
             
             MERGE              
             INTO {<таблица>|<представление>}
             USING ...
             ON <условие соединения>
             WHEN NOT MATCHED [ BY TARGET ]
               [ AND <доп.условие> ]
               THEN INSERT [(<список столбцов>)]
               VALUES (<значения>);
                                                        .




CALL
------------------

.. code-block::
    :redlines: 3,5,6,7,8,9,10,11,12,13,14,15
    :greenlines: 1,2,4
    :caption: Oracle
    
    CALL
    { [<схема>.] [<TYPE>.|<пакет>.] { <функция> | <процедура> | <метод> }
      [ @dblink_name ]
      ( [ <аргумент> [, <аргумент> ]... ] )
    | { table_alias.column.
      | object_table_alias.
      | (<выражение>).
      }
      { <атрибут> [.<атрибут> ]...
        [.<метод> ([ <аргумент> [, <аргумент> ]... ]) ]
      | <метод> ([ <аргумент> [, <аргумент> ]... ])
      }
    }
    [ INTO :host_variable
    [ [ INDICATOR ] :indicator_variable ] ] ;   


Вызов процедуры
^^^^^^^^^^^^^^^^


Вызов функции
^^^^^^^^^^^^^^


PSQL Blocks
------------------

.. code-block::
    :redlines: 1
    :greenlines: 2,3,4,5,6,7,8,10,11,12,14,15,16
    :caption: Oracle
    
    [ << label >> ]... 
    [ DECLARE 
       { <объявление_1>;... [<объявление_2>;]... 
       | <объявление_2>;} ]
    BEGIN 
       <блок psql операторов> ...
       [ EXCEPTION <обработка исключений> ] 
    END;

    <объявление_1> ::= { <объявление типа> | <объявление курсора> 
                       | <объявление переменных и констант>
                       | <объявление функции> | <объявление процедуры> }

    <объявление_2> ::= { <объявление курсора> | <создание курсора> | <объявление функции> 
                       | <реализация функции> | <объявление процедуры> | <реализация процедуры> }


Анонимные PSQL блоки
^^^^^^^^^^^^^^^^^^^^^^^

.. list-table::
      :class: borderless
      
      * - :ess:`Oracle`
          
          .. code-block::
             :greenlines: 1,2,3,4,5,6,7
             
             [DECLARE
               { <объявление_1>;... [<объявление_2>;]... 
               | <объявление_2>;} ]
             BEGIN
               <блок psql операторов> ...
               [ EXCEPTION <обработка исключений> ... ]
             END;
             
        - :ess:`Rdb`
        
          .. code-block:: 
             :greenlines: 1,2,3,4,5,6,7
             
             EXECUTE BLOCK AS
               [<объявление> [<объявление> ...] ]
               
             BEGIN
               <блок psql операторов>

             END;