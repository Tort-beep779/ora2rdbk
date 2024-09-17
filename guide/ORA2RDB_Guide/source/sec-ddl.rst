.. _sec:ddl:

Преобразование DDL операций (``CREATE``, ``ALTER``, ``DROP``)
===================================================================

.. _subsec:table:

Таблицы (``Table``)
--------------------

``CREATE TABLE``
^^^^^^^^^^^^^^^^^^

Описание оператора ``CREATE TABLE`` в соответствии с грамматикой Oracle осуществляется следующим образом:

.. code-block::
    :redlines: 3, 5, 7, 8, 9, 10, 14, 15, 16, 17, 19, 20, 23, 25
    :greenlines: 1, 2, 4, 6, 11, 13, 18, 22, 24, 26
    
    CREATE 
    [GLOBAL TEMPORARY 
     | PRIVATE TEMPORARY | SHARDED | DUPLICATED | [ IMMUTABLE ] BLOCKCHAIN | IMMUTABLE ] 
    TABLE [ <схема>. ] <имя таблицы>
    [ SHARING = { METADATA | DATA | EXTENDED DATA | NONE } ]
    { <реляционная таблица> 
    | <таблица объектов>
    | <таблицы документов XML> }
    [ MEMOPTIMIZE FOR READ ]  [ MEMOPTIMIZE FOR WRITE ]
    [ PARENT [ <схема>. ] <имя таблицы> ] 
    ;

    <реляционная таблица> ::= [ (<реляционные свойства>) ]
                              [ <предложения для immutable таблиц>]
                              [ <предложения для blockchain таблиц> ]
                              [ DEFAULT COLLATION <название сортировки> ]
                              [ ON COMMIT { DROP | PRESERVE } DEFINITION ]
                              [ ON COMMIT { DELETE | PRESERVE } ROWS ]
                              [ <физические свойства> ]
                              [ <табличные свойства> ]

    <реляционные свойства> ::= { <определение столбца>
                               | PERIOD FOR ... 
                               | <ограничение таблицы>
                               | SUPPLEMENTAL LOG ... 
                               } [, ... ] 



Создание таблицы
""""""""""""""""""

.. list-table::
      :class: borderless
      
      * - :ess:`Oracle`
      
          .. code-block::
             :greenlines: 1, 2, 3, 4, 5
             
             CREATE TABLE [<схема>.] <имя таблицы>
             (  <опред. столбца> 
             [,{<опред. столбца>|<огран. таблицы>}...]);
                                                        
        - :ess:`Rdb`
        
          .. code-block:: 
             :greenlines: 1, 2, 3, 4, 5
             
              CREATE TABLE <имя таблицы>
              (  <опред. столбца> 
              [,{<опред. столбца>|<огран. таблицы>}...]);




Глобальные временные таблицы (GTTs)
"""""""""""""""""""""""""""""""""""""

.. list-table::
      :class: borderless
      
      * - :ess:`Oracle`
      
          .. code-block::
             :greenlines: 1, 2, 3, 4, 5
             
             CREATE GLOBAL TEMPORARY TABLE 
                                 [<схема>.] <имя таблицы>
             (  <опред. столбца> 
             [,{<опред. столбца>|<огран. таблицы>}...])
             [ ON COMMIT { DELETE | PRESERVE } ROWS ]
                                                        
        - :ess:`Rdb`
        
          .. code-block:: 
             :greenlines: 1, 2, 3, 4, 5
             
              CREATE GLOBAL TEMPORARY TABLE 
                                            <имя таблицы>
              (  <опред. столбца> 
              [,{<опред. столбца>|<огран. таблицы>}...])
              [ON COMMIT {DELETE | PRESERVE} ROWS]
  	 


Определение столбца
""""""""""""""""""""""

.. code-block::
    :greenlines: 1, 2, 3
    
    <определение столбца> ::= <определение обычного столбца>
                              | <определение столбца идентификаторов>
                              | <определение вычисляемого (виртуального) столбца>



.. raw:: latex

  \setlength\parindent{0pt}

:strong:`Определение обычного столбца`

.. raw:: latex

  \setlength\parindent{25pt}

.. list-table::
      :class: borderless
      
      * - :ess:`Oracle`
      
          .. code-block::
             :redlines: 3, 5
             :greenlines: 1, 2, 4, 6
             
             <имя столбца> [<тип данных> 
                            [COLLATE <сортировка>]]
             [ SORT ] [ VISIBLE | INVISIBLE ]
             [ DEFAULT [ ON NULL ] <выражение>]
             [ ENCRYPT <спецификация шифрования> ]
             [ <ограничение столбца>]
                                                         .

        - :ess:`Rdb`
        
          .. code-block:: 
             :greenlines: 1, 4, 6, 7
   
              <имя столбца> <тип данных>


              [DEFAULT {<литерал>|NULL|<конт.перем.>}]

              [<ограничение столбца>]
              [COLLATE <порядок сортировки>]


.. raw:: latex

  \setlength\parindent{0pt}

:strong:`Определение столбца идентификаторов`

.. raw:: latex

  \setlength\parindent{25pt}

.. list-table::
      :class: borderless
      
      * - :ess:`Oracle`

          .. code-block::
              :redlines: 3, 6
              :greenlines: 1, 2, 4, 5, 7
          
              <имя столбца> [<тип данных> 
                             [COLLATE <сортировка> ]]
              [ SORT ] [ VISIBLE | INVISIBLE ]
              [ GENERATED [ ALWAYS | BY DEFAULT [ON NULL] ]
                AS IDENTITY [(<опции идентификаторов>)]]
              [ ENCRYPT <спецификация шифрования> ]
              [ <ограничение столбца> ]

        - :ess:`Rdb`    

          .. code-block::
              :greenlines: 1, 4, 5, 7

              <имя столбца> <тип данных>
    	       

              GENERATED {ALWAYS | BY DEFAULT} 
              AS IDENTITY [(<опции идентификаторов>)]
    	 
              [<ограничение столбца>]  


.. raw:: latex

  \setlength\parindent{0pt}

:strong:`Определение вычисляемого (виртуального) столбца`

.. raw:: latex

  \setlength\parindent{25pt}

.. list-table::
      :class: borderless
      
      * - :ess:`Oracle`

          .. code-block::
              :redlines: 2, 3, 5, 6, 7
              :greenlines: 1, 4
          
              <имя столбца> [<тип данных> 
                             [COLLATE <сортировка> ]]
              [ VISIBLE | INVISIBLE ]
              [ GENERATED ALWAYS ] AS (<выражение>) 
              [ VIRTUAL ]
              [ EVALUATE USING ... ] [ UNUSABLE ... ]
              [<ограничение столбца>] 

        - :ess:`Rdb`    

          .. code-block::
              :greenlines: 1, 4, 5, 7

              <имя столбца> [<тип данных>]
              
              
              GENERATED ALWAYS AS (<выражение>)          
                                                                  
                                                    
                                                          .
    

Ограничение столбца
""""""""""""""""""""

Различия в синтаксисе выглядят так:

.. list-table::
      :class: borderless
      
      * - :ess:`Oracle`
      
          .. code-block:: 
            :redlines: 12
            :greenlines: 1,2,3,4,5,6,10,11

            [ CONSTRAINT <имя ограничения> ]
            { [ NOT ] NULL
            | UNIQUE
            | PRIMARY KEY
            | REFERENCES [<схема>.]<объект> [(<столбцы>)] 
              [ON DELETE { CASCADE | SET NULL } ]



            | CHECK (<условие столбца>)
            }
            [ <состояние ограничения> ]

        - :ess:`Rdb`
        
          .. code-block:: 
            :redlines: 7,8,9
            :greenlines: 1,2,3,4,5,6,10,11

            [ CONSTRAINT <имя ограничения> ]
            { NOT NULL
            | UNIQUE      
            | PRIMARY KEY 
            | REFERENCES <таблица> [(<столбцы>)]
              [ON DELETE { CASCADE | SET NULL   
                         | SET DEFAULT | NO ACTION}]
              [ON UPDATE { CASCADE | SET NULL 
                         | SET DEFAULT | NO ACTION}]
            | CHECK (<условие столбца>)
            }
                                                        .
   
Ограничение таблицы
""""""""""""""""""""

Различия в синтаксисе выглядят так:

.. list-table::
      :class: borderless
      
      * - :ess:`Oracle`
      
          .. code-block::
            :redlines: 12
            :greenlines: 1,2,3,4,5,6,10,11

            [ CONSTRAINT <имя ограничения> ]
            { UNIQUE (<список столбцов>)
            | PRIMARY KEY (<список столбцов>)
            | FOREIGN KEY (<список столбцов>) 
              REFERENCES [<схема>.]<объект> [(<столбцы>)] 
              [ON DELETE { CASCADE | SET NULL } ]



            | CHECK (<условие столбца>)
            } 
            [ <состояние ограничения> ]
            
        - :ess:`Rdb`
        
          .. code-block:: 
            :redlines: 7,8,9
            :greenlines: 1,2,3,4,5,6,10,11

            [CONSTRAINT <имя ограничения>]
            { UNIQUE (<список столбцов>) 
            | PRIMARY KEY (<список столбцов>) 
            | FOREIGN KEY (<список столбцов>)
              REFERENCES <имя таблицы> [(<столбцы>)]
              [ON DELETE { CASCADE | SET NULL
                         | SET DEFAULT |  NO ACTION }]
              [ON UPDATE { CASCADE | SET NULL
                         | SET DEFAULT |  NO ACTION }]
            | CHECK (<условие столбца>)
            }
                                                        .
 

``ALTER TABLE``
^^^^^^^^^^^^^^^^

.. code-block::
    :redlines: 2, 3, 4, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 24, 25, 28, 29, 30, 34, 35
    :greenlines: 1, 5, 6, 19, 21, 22, 23, 26, 27, 31, 33, 36, 37
    
    ALTER TABLE [ <схема>. ] <имя таблицы>
    [ { (MEMOPTIMIZE FOR READ) | (NO MEMOPTIMIZE FOR READ) } ]
    [ { (MEMOPTIMIZE FOR WRITE) | (NO MEMOPTIMIZE FOR WRITE) } ]
    [ <изменение свойств таблицы>
    | <изменение столбцов>
    | <изменение ограничений>
    | <изменение партиционированной таблицы>
    | <изменение внешней таблицы>
    | <предложение MOVE>
    | <изменить на партиционированную таблицу>
    | <предложение MODIFY OPAQUE TYPE>
    | <изменения для immutable таблиц>
    | <изменения для blockchain таблиц>
    ]
    [ <предложение ENABLE-DISABLE>
    | { ENABLE | DISABLE }
      { TABLE LOCK | ALL TRIGGERS | CONTAINER_MAP | CONTAINERS_DEFAULT }
    ] ...
    ;

    <изменение столбцов> ::= { { <добавление столбца>
                               | <модификация столбца>
                               | <удаление столбца>
                               | ADD ( PERIOD FOR ... )
                               | DROP ( PERIOD FOR ... )
                               }
                             | <переименование столбца>
                             | MODIFY NESTED TABLE <collection_item> RETURN AS { LOCATOR | VALUE }
                             | MODIFY LOB (<LOB_item>) (...) 
                             | MODIFY VARRAY <varray_item> ( ... ) 
                             }

    <изменение ограничений> ::= { <добавление ограничения>
                                | <модификация ограничения>
                                | <переименование ограничения>
                                | <удаление ограничения>
                                }


Добавление столбца
"""""""""""""""""""

.. list-table::
      :class: borderless
      
      * - :ess:`Oracle`
      
          .. code-block::
             :redlines: 4, 5
             :greenlines: 1, 2, 3
             
             ALTER TABLE [ <схема>. ] <имя таблицы>
             ADD (<определение столбца> 
                  [, <определение столбца> ...])
             [ <свойства столбцов> ]
             [ ( PARTITION ... [, PARTITION ...]... ) ]
                                                         

        - :ess:`Rdb`
        
          .. code-block:: 
             :greenlines: 1, 2, 3
   
              ALTER TABLE <имя таблицы>
              ADD <определение столбца> 
              [, ADD <определение столбца> ...]

                                                        .

Модификация столбца
"""""""""""""""""""""


.. code-block::
    :redlines: 6, 7
    :greenlines: 1, 2, 3, 4, 5, 8
    :caption: Oracle
    
    ALTER TABLE [ <схема>. ] <имя таблицы>
    MODIFY
        { ( <модификация обычного столбца> [, <модификация обычного столбца> ]... )
        | ( <модификация столбца идентификаторов> [, <модификация столбца идентификаторов> ]... )
        | ( <модификация вычисляемого столбца> [, <модификация вычисляемого столбца> ]... )
        | ( <столбец> { VISIBLE | INVISIBLE } [, <столбец> { VISIBLE | INVISIBLE } ]... )
        | COLUMN <столбец> [NOT] SUBSTITUTABLE AT ALL LEVELS [ FORCE ]
        }
              



.. raw:: latex

  \setlength\parindent{0pt}

:strong:`Модификация обычного столбца`

.. raw:: latex

  \setlength\parindent{25pt}

.. list-table::
      :class: borderless
      
      * - :ess:`Oracle`
      
          .. code-block::
             :redlines: 4, 6, 8,9
             :greenlines: 1, 2, 3, 5, 7, 10
             
             ALTER TABLE [<схема>.] <имя таблицы>
             MODIFY ( <столбец> 
                      [ <тип данных> ]
                      [ COLLATE <сортировка> ]
                      [ DEFAULT [ON NULL] <выражение>]
                      [ ENCRYPT ... | DECRYPT ]
                      [ <ограничение строки> ... ]
                      [ <LOB_storage_clause> ]
                      [ <alter_XMLSchema_clause> ]       
                      [ , <столбец> ... ] )

        - :ess:`Rdb`
        
          .. code-block:: 
             :greenlines: 1, 2, 3, 5, 7, 10
             
             ALTER TABLE <имя таблицы>
             ALTER [COLUMN] <столбец> 
             {TYPE <тип данных> 

             | SET DEFAULT {<литерал>|NULL|<конт.перем.>}

             | {SET|DROP} NOT NULL}


             [, ALTER [COLUMN] <столбец> ... ]


.. raw:: latex

  \setlength\parindent{0pt}

:strong:`Модификация столбца идентификаторов`

.. raw:: latex

  \setlength\parindent{25pt}


.. list-table::
      :class: borderless
      
      * - :ess:`Oracle`
      
          .. code-block::
             :redlines: 3, 4, 9, 10, 11, 12
             :greenlines: 1, 2, 5, 6, 7, 8, 13
             
             ALTER TABLE [<схема>.] <имя таблицы>
             MODIFY ( <столбец> 
                      [ <тип данных> ]
                      [ COLLATE <сортировка> ]
                      [ GENERATED [ALWAYS|BY DEFAULT 
                        [ON NULL]] AS IDENTITY 
                        [ ( <опции идентификаторов> ) ]
                        | DROP IDENTITY ]
                      [ ENCRYPT ... | DECRYPT ]
                      [ <ограничение строки> ... ]
                      [ <LOB_storage_clause> ]
                      [ <alter_XMLSchema_clause> ]       
                      [ , <столбец> ... ] )

        - :ess:`Rdb`
        
          .. code-block:: 
             :greenlines: 1, 2, 5, 6, 7, 8, 13
             
             ALTER TABLE <имя таблицы>
             ALTER [COLUMN] <столбец> 


             {SET GENERATED {ALWAYS | BY DEFAULT} 
              [<опции идентификаторов>...]
              | <опции идентификаторов>...
              | DROP IDENTITY}




             [, ALTER [COLUMN] <столбец> ... ]

.. raw:: latex

  \setlength\parindent{0pt}

:strong:`Модификация вычисляемого (виртуального) столбца`

.. raw:: latex

  \setlength\parindent{25pt} 

.. list-table::
      :class: borderless
      
      * - :ess:`Oracle`
      
          .. code-block::
             :redlines: 4, 6, 7, 8, 9
             :greenlines: 1, 2, 3, 5, 10
             
             ALTER TABLE [<схема>.] <имя таблицы>
             MODIFY ( <столбец> 
                      [ <тип данных> ]
                      [ COLLATE <сортировка> ]
                      [ GENERATED ALWAYS] AS (<выражение>) 
                      [ VIRTUAL ]
                      EVALUATE USING ...
                      [ UNUSABLE BEFORE ... ]
                      [ UNUSABLE BEGINNING WITH ... ]    
                      [ , <столбец> ... ] )

        - :ess:`Rdb`
        
          .. code-block:: 
             :greenlines: 1, 2, 3, 5, 10
             
             ALTER TABLE <имя таблицы>
             ALTER [COLUMN] <столбец> 
             [TYPE <тип данных>] 
             
             GENERATED ALWAYS AS (<выражение>)




             [, ALTER [COLUMN] <столбец> ... ]


Удаление столбца
"""""""""""""""""

.. list-table::
      :class: borderless
      
      * - :ess:`Oracle`
      
          .. code-block::
             :redlines: 3, 4, 5, 6, 7, 8, 9
             :greenlines: 1, 2, 10
             
             ALTER TABLE [<схема>.] <имя таблицы>
             { DROP {COLUMN <имя> | (<имя> [, <имя> ]...)}
                    [{CASCADE CONSTRAINTS|INVALIDATE}...]
                    [ CHECKPOINT [<число>] ]  
             | SET UNUSED {COLUMN <имя>|(<имя>[,<имя>])}
                    [{CASCADE CONSTRAINTS|INVALIDATE}... ]
                    [ ONLINE ]             
             | DROP {UNUSED COLUMNS|COLUMNS CONTINUE}
                    [ CHECKPOINT [<число>] ]
             }

        - :ess:`Rdb`
        
          .. code-block:: 
             :greenlines: 1, 2, 3
             
             ALTER TABLE <имя таблицы>
             DROP <имя столбца>
             [, DROP <имя столбца> ... ]






                                                         .


Переименование столбца
"""""""""""""""""""""""

.. list-table::
      :class: borderless
      
      * - :ess:`Oracle`
      
          .. code-block::
             :greenlines: 1, 2
             
             ALTER TABLE [<схема>.] <имя таблицы>
             RENAME COLUMN <имя столбца> TO <новое имя>
                                                        
        - :ess:`Rdb`
        
          .. code-block:: 
             :greenlines: 1, 2
             
             ALTER TABLE <имя таблицы>
             ALTER [COLUMN] <имя столбца> TO <новое имя>


Добавление ограничения
"""""""""""""""""""""""

.. list-table::
      :class: borderless
      
      * - :ess:`Oracle`
      
          .. code-block::
             :greenlines: 1, 2
             
             ALTER TABLE [<схема>.] <имя таблицы>
             ADD <ограничение таблицы>
                                                        
        - :ess:`Rdb`
        
          .. code-block:: 
             :greenlines: 1, 2
             
             ALTER TABLE <имя таблицы>
             ADD <ограничение таблицы>


Удаление ограничения
"""""""""""""""""""""""

.. list-table::
      :class: borderless
      
      * - :ess:`Oracle`
      
          .. code-block::
             :redlines: 3, 4, 5, 6
             :greenlines: 1, 2
             
             ALTER TABLE [<схема>.] <имя таблицы>
             DROP { CONSTRAINT <имя ограничения>
                      [ CASCADE ] [{ KEEP | DROP } INDEX ]
                    | PRIMARY KEY
                    | UNIQUE (<столбец>)
                  } [ ONLINE ]
                                                        
        - :ess:`Rdb`
        
          .. code-block:: 
             :greenlines: 1, 2
             
             ALTER TABLE <имя таблицы>
             DROP CONSTRAINT <имя ограничения>



                                                        .



``DROP TABLE``
^^^^^^^^^^^^^^^^^

.. list-table::
      :class: borderless
      
      * - :ess:`Oracle`
      
          .. code-block::
             :redlines: 2
             :greenlines: 1
             
             DROP TABLE [ <схема>. ] <имя таблицы>
             [ CASCADE CONSTRAINTS ] [ PURGE ] ;
                                                        
        - :ess:`Rdb`
        
          .. code-block:: 
             :greenlines: 1
             
             DROP TABLE <имя таблицы>;
                                                        .


.. _subsec:sequence:

Последовательности (``Sequence``)
----------------------------------

``CREATE SEQUENCE``
^^^^^^^^^^^^^^^^^^^^

.. list-table::
      :class: borderless
      
      * - :ess:`Oracle`
      
          .. code-block::
             :redlines: 2, 5, 6, 7, 8, 9, 10, 11, 12
             :greenlines: 1, 3, 4, 13, 14
             
             CREATE SEQUENCE [ <схема>. ] <имя посл-ти>
               [ SHARING = { METADATA | DATA | NONE } ]
               [ START WITH <начальное значение>
               | INCREMENT BY <приращение>
               | { MAXVALUE <число> | NOMAXVALUE }
               | { MINVALUE <число> | NOMINVALUE }
               | { CYCLE | NOCYCLE }
               | { CACHE <число> | NOCACHE }
               | { ORDER | NOORDER }
               | { KEEP | NOKEEP }
               | { SCALE {EXTEND | NOEXTEND} | NOSCALE }
               | { SESSION | GLOBAL }
               ]...
             ;
                                                        
        - :ess:`Rdb`
        
          .. code-block:: 
             :greenlines: 1, 3, 4
             
             CREATE SEQUENCE <имя последовательности>

               [START WITH <начальное значение>] 
               [INCREMENT [BY] <приращение>];









                                                        .


``ALTER SEQUENCE``
^^^^^^^^^^^^^^^^^^^^
  
.. list-table::
      :class: borderless
      
      * - :ess:`Oracle`
      
          .. code-block::
             :redlines: 4, 5, 6, 7, 8, 9, 10, 11, 12
             :greenlines: 1, 2, 3, 13, 14
             
             ALTER SEQUENCE [ <схема>. ] <имя посл-ти>
               { RESTART [START WITH <начальное значение>] 
               | INCREMENT BY <приращение>
               | { MAXVALUE <число> | NOMAXVALUE }
               | { MINVALUE <число> | NOMINVALUE }               
               | { CYCLE | NOCYCLE }
               | { CACHE <число> | NOCACHE }
               | { ORDER | NOORDER }
               | { KEEP | NOKEEP }
               | { SCALE {EXTEND | NOEXTEND} | NOSCALE }
               | { SHARD {EXTEND | NOEXTEND} | NOSHARD }
               | { SESSION | GLOBAL }
               } ... ;
                                                        
        - :ess:`Rdb`
        
          .. code-block:: 
             :greenlines: 1, 2, 3
             
             ALTER SEQUENCE <имя последовательности>
              [RESTART [WITH <начальное значение>]]
              [INCREMENT [BY] <приращение>]









                                                        .  

``DROP SEQUENCE``
^^^^^^^^^^^^^^^^^^^^
  
.. list-table::
      :class: borderless
      
      * - :ess:`Oracle`
      
          .. code-block::
             :greenlines: 1
             
             DROP SEQUENCE [ <схема>. ] <имя посл-ти>;
                                                        
        - :ess:`Rdb`
        
          .. code-block:: 
             :greenlines: 1
             
             DROP SEQUENCE <имя последовательности>;                                                         
    

.. _subsec:index:

Индексы (``Index``)
---------------------  

``CREATE INDEX``
^^^^^^^^^^^^^^^^^^^^


      
.. code-block::
    :redlines: 3, 4, 6, 7, 10, 12
    :greenlines: 1, 2, 5, 9, 11
    
    CREATE [ UNIQUE | BITMAP ] INDEX [ <схема>. ] <имя индекса>
    ON { <табличный индекс>
       | <кластерный индекс>
       | <bitmap индекс>
       }
    [ USABLE | UNUSABLE ]
    [ { DEFERRED | IMMEDIATE } INVALIDATION ] ;

    <табличный индекс> ::= [ <схема>. ] <имя таблицы> 
                           [ <алиас таблицы> ]
                           (<выражение индекса> [ASC|DESC] [,<выражение индекса> [ASC|DESC]]...)
                           [ <атрибуты индекса> ]


Создание табличного индекса
""""""""""""""""""""""""""""""

.. list-table::
      :class: borderless
      
      * - :ess:`Oracle`
      
          .. code-block::
             :greenlines: 1, 2, 3, 4, 5
             
             CREATE [UNIQUE] INDEX 
             [<схема>.] <имя индекса> 
             ON [ <схема>. ] <имя таблицы> 
             ( <выражение индекса> [ASC|DESC] 
               [, <выражение индекса> [ASC|DESC]]...);
                                                        
        - :ess:`Rdb`
        
          .. code-block:: 
             :greenlines: 1, 2, 3, 4, 5
             
             CREATE [UNIQUE] [ASC[ENDING] | DESC[ENDING]]
             INDEX <имя индекса> 
             ON <имя таблицы>
             { (<столбец> [, <столбец> …])
             | COMPUTED BY (<выражение индекса>) };


``ALTER INDEX``
^^^^^^^^^^^^^^^^^^^^

.. code-block::
    :redlines: 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 14, 15, 16, 17, 18, 19, 20
    :greenlines: 1, 13, 21
    
    ALTER INDEX [ <схема>. ] <имя индекса>
    { { <предложение DEALLOCATE UNUSED>
      | <предложение ALLOCATE EXTENT>
      | SHRINK SPACE [ COMPACT ] [ CASCADE ]
      | { NOPARALLEL | PARALLEL [<число>] }
      | <физические атрибуты>
      | { LOGGING | NOLOGGING |  FILESYSTEM_LIKE_LOGGING }
      | INDEXING { PARTIAL | FULL }
      } ...
    | <предложение REBUILD>
    | PARAMETERS ( 'ODCI_parameters' )
    | COMPILE
    | { ENABLE | DISABLE }
    | UNUSABLE [ ONLINE ] [ { DEFERRED | IMMEDIATE } INVALIDATION ]
    | VISIBLE | INVISIBLE
    | RENAME TO <новое имя>
    | COALESCE [ CLEANUP ] [ ONLY ] [ <предложение PARALLEL> ]
    | { MONITORING | NOMONITORING } USAGE
    | UPDATE BLOCK REFERENCES
    | <предложение для секционированных индексов>
    };



``DROP INDEX``
^^^^^^^^^^^^^^^

.. list-table::
      :class: borderless
      
      * - :ess:`Oracle`
      
          .. code-block::
             :redlines: 2, 3
             :greenlines: 1
             
             DROP INDEX [ <схема>. ] <имя индекса>
             [ONLINE] [FORCE] 
             [{DEFERRED|IMMEDIATE} INVALIDATION];
                                                        
        - :ess:`Rdb`
        
          .. code-block:: 
             :greenlines: 1
             
             DROP INDEX <имя индекса>;

                                                         .

.. _subsec:view:

Представления (``View``)
--------------------------

``CREATE VIEW``
^^^^^^^^^^^^^^^^^^^^

.. code-block::
    :redlines:  3, 5, 7, 8, 11, 12, 13, 14, 15, 17, 20, 21
    :greenlines: 1, 2, 4, 6, 9, 10, 16, 19
    
    CREATE [OR REPLACE]
    [[NO] FORCE]
    [ EDITIONING | EDITIONABLE [ EDITIONING ] | NONEDITIONABLE ]
    VIEW [ <схема>. ] <имя представления>
    [ SHARING = { METADATA | DATA | EXTENDED DATA | NONE } ]
    [ ( { <алиас> 
        [ VISIBLE | INVISIBLE ] [ <ограничение строки>... ]
        | <ограничение представления> }
        [, ... ]
      )
    | <предложение для объектного представления>
    | <предложение для XMLType представления>
    ]
    [ DEFAULT COLLATION <сортировка> ]
    [ BEQUEATH { CURRENT_USER | DEFINER } ]
    AS <оператор SELECT> [ <предложения с ограничениями> ]
    [ CONTAINER_MAP | CONTAINERS_DEFAULT ] ;

    <предложения с ограничениями> ::= WITH { CHECK OPTION
                                           | READ ONLY
                                           } [ CONSTRAINT <имя ограничения> ]


Создание представления
""""""""""""""""""""""""

.. list-table::
      :class: borderless
      
      * - :ess:`Oracle`
          
          .. code-block::
             :greenlines: 1,2,3,4,5
             
             CREATE [OR REPLACE] 
             VIEW [ <схема>. ] <имя представления> 
             [( <алиас> [,<алиас>] )]
  	         AS <оператор SELECT>
  	         [WITH CHECK OPTION]
  	                                                        
        - :ess:`Rdb`
        
          .. code-block:: 
             :greenlines: 1,2,3,4,5
             
             CREATE [OR ALTER] 
             VIEW <имя представления> 
             [(<столбец> [, <столбец> ...])]
  	         AS <оператор SELECT>
  	         [WITH CHECK OPTION]


Предложение FORCE
""""""""""""""""""

``ALTER VIEW``
^^^^^^^^^^^^^^^

.. code-block:: 
    :redlines:  1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12
    :caption: Oracle
    
    ALTER VIEW [ <схема>. ] <имя представления> 
    { ADD <ограничение представления>
    | MODIFY CONSTRAINT <имя ограничения>
      { RELY | NORELY }
    | DROP { CONSTRAINT <имя ограничения>
            | PRIMARY KEY
            | UNIQUE (<столбец> [, <столбец> ]...)
            }
    | COMPILE
    | { READ ONLY | READ WRITE }
    | { EDITIONABLE | NONEDITIONABLE }
    } ;


``DROP VIEW``
^^^^^^^^^^^^^^^

.. list-table::
      :class: borderless
      
      * - :ess:`Oracle`
      
          .. code-block::
             :redlines: 2
             :greenlines: 1
             
             DROP VIEW [ <схема>. ] <имя представления>  
             [ CASCADE CONSTRAINTS ] ;
  	                                                        
        - :ess:`Rdb`
        
          .. code-block:: 
             :greenlines: 1
             
             DROP VIEW <имя представления> ;
                                                         .


.. _subsec:function:

Хранимые функции (``Function``)
----------------------------------

``CREATE FUNCTION``
^^^^^^^^^^^^^^^^^^^^

.. code-block::
    :redlines:  2, 6, 8, 9, 11, 12, 13, 14, 15, 16, 30, 33
    :greenlines: 1, 3, 4, 5, 7, 10, 17, 18, 19, 20, 21, 22, 24, 26, 28, 29, 31, 32
    :caption: Oracle
    
    CREATE [ OR REPLACE ] 
    [ EDITIONABLE | NONEDITIONABLE ]
    FUNCTION [ <схема>. ] <имя функции>
       [ ( <IN|OUT параметр> [, <IN|OUT параметр>]... ) ] 
       RETURN <тип возвращаемого значения> 
       [ SHARING = { METADATA | NONE } ]
       [ AUTHID { CURRENT_USER | DEFINER }]
       [ ACCESSIBLE BY ( <средство доступа> [, <средство доступа> ]... ) ]
       [ DEFAULT COLLATION <опция сортировки> ]   
       [ DETERMINISTIC ]
       [ PARALLEL_ENABLE ... ]
       [ RESULT_CACHE ... ]
       [ AGGREGATE USING ... ]
       [ PIPELINED ... ]
       [ SQL_MACRO ]
       { { IS | AS } <внешний модуль> ;
       | { IS | AS } [ <объявление_1>;... [<объявление_2>;]... | <объявление_2>;... ] 
         BEGIN 
           <блок операторов> ...
           [ EXCEPTION <exception_handler> [ <exception_handler> ]... ] 
         END [ <имя функции>] ;
       }

    <IN-параметр> ::= <имя параметра> [IN] <тип данных> [{:=|DEFAULT} <выражение>]

    <OUT-параметр> ::= <имя параметра> {OUT|IN OUT} [NOCOPY] <тип данных>

    <объявление_1> ::= { <объявление типа> | <объявление курсора> 
                       | <объявление переменных и констант>
                       | <объявление функции> | <объявление процедуры> }

    <объявление_2> ::= { <объявление курсора> | <создание курсора> | <объявление функции> 
                       | <реализация функции> | <объявление процедуры> | <реализация процедуры> }




Создание функции с IN параметрами
""""""""""""""""""""""""""""""""""

.. list-table::
      :class: borderless
      
      * - :ess:`Oracle`
      
          .. code-block::
             :greenlines: 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11
             
             CREATE [ OR REPLACE ] 
             FUNCTION [ <схема>. ] <имя функции>
              [(<IN-параметр> [,<IN-параметр>...])] 
             RETURN <тип возвращаемого значения> 
             [AUTHID { CURRENT_USER | DEFINER }]
             [DETERMINISTIC]
             {IS|AS} 
                 [ <объявление> [<объявление> ...] ] 
             BEGIN 
                 <блок операторов> ...
             END [ <имя функции> ] ;              
             
  	                                                        
        - :ess:`Rdb`
        
          .. code-block:: 
             :greenlines: 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11
             
             CREATE [ OR ALTER ] 
             FUNCTION <имя хранимой функции>
              [(<IN-параметр> [,<IN-параметр>...])]
             RETURNS <тип возвращаемого значения> 
             [DETERMINISTIC]
             [SQL SECURITY {DEFINER | INVOKER}]
             AS
                 [<объявление> [<объявление> ...] ]
             BEGIN
                 <блок операторов>
             END ;

Создание функции с OUT параметрами
""""""""""""""""""""""""""""""""""""""""""    

Функция с out-параметрами конвертируется в селективную процедуру, из которой можно получить out-параметры. При конвертации:
Те же изменения, что и в стандартной функции
“FUNCTION” заменяется на “PROCEDURE”  
Удаляются модификаторы  (см.раздел “модификаторы”)
В возвращаемые параметры добавляется переменная 
“RET_VAL”, которая принимает тип выходного параметра исходной функции
В возвращаемые параметры добавляется переменная, которая принимает тип входного параметра исходной функции.
Изменяется оператор RETURN в теле функции (см. раздел “Return Statement”)

.. list-table::
      :class: borderless
      
      * - :ess:`Oracle`
      
          .. code-block::
             :greenlines: 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12
             
             CREATE [ OR REPLACE ] 
             FUNCTION [ <схема>. ] <имя функции>
              (<OUT-параметр> [,<IN|OUT параметр>...])
             RETURN <тип возвращаемого значения> 

             [AUTHID { CURRENT_USER | DEFINER }]
             [DETERMINISTIC]
             {IS|AS} 
                 [ <объявление> [<объявление> ...] ] 
             BEGIN 
                 <блок операторов> ...
             END [ <имя функции> ] ;              
             
  	                                                        
        - :ess:`Rdb`
        
          .. code-block:: 
             :greenlines: 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12
             
             CREATE [OR ALTER] 
             PROCEDURE <имя функции> 
               (<OUT-параметр> [,<IN|OUT параметр>...])
             RETURNS (<имя перем.><тип возвр.знач.>,
                      <OUT-параметр>_OUT)
             [SQL SECURITY {DEFINER | INVOKER}]

             AS 
               [<объявление> [<объявление> ...] ]
             BEGIN
               <блок операторов>
             END ;


``ALTER FUNCTION``
^^^^^^^^^^^^^^^^^^^^

.. code-block::
    :redlines:  1, 2, 3, 4
    :caption: Oracle
    
    ALTER FUNCTION [<схема>.] <имя функции>
    { COMPILE [ DEBUG ] [ <параметры компиляции> ... ] [ REUSE SETTINGS ] 
    | { EDITIONABLE | NONEDITIONABLE } 
    }


``DROP FUNCTION``
^^^^^^^^^^^^^^^^^^^^

.. list-table::
      :class: borderless
      
      * - :ess:`Oracle`
      
          .. code-block::
             :greenlines: 1
             
             DROP FUNCTION [ <схема>. ] <имя функции> ;


        - :ess:`Rdb`
        
          .. code-block:: 
             :greenlines: 1, 2, 3
             
             DROP FUNCTION <имя функции>;



.. _subsec:procedure:

Хранимые процедуры (``Procedure``)
------------------------------------

``CREATE PROCEDURE``
^^^^^^^^^^^^^^^^^^^^

.. code-block::
    :redlines:  2, 5, 7, 8, 9, 23, 26
    :greenlines: 1, 3, 4, 6, 10, 11, 12, 13, 14, 15, 17, 19, 20, 21, 22, 24, 25
    :caption: Oracle
    
    CREATE [ OR REPLACE ] 
    [ EDITIONABLE | NONEDITIONABLE ]
    PROCEDURE [ <схема>. ] <имя процедуры>
       [ ( <IN|OUT параметр> [, <IN|OUT параметр>]... ) ] 
       [ SHARING = { METADATA | NONE } ]
       [ AUTHID { CURRENT_USER | DEFINER }]
       [ ACCESSIBLE BY ( <средство доступа> [, <средство доступа> ]... ) ]
       [ DEFAULT COLLATION <опция сортировки> ]   
    { { IS | AS } <внешний модуль>
    | { IS | AS } [ <объявление_1>;... [<объявление_2>;]... | <объявление_2>;... ] 
    BEGIN 
        <блок операторов> ...
        [ EXCEPTION <exception_handler> [ <exception_handler> ]... ] 
    END [<имя процедуры>] ;
    }

    <IN-параметр> ::= <имя параметра> [IN] <тип данных> [{:=|DEFAULT} <выражение>]

    <OUT-параметр> ::= <имя параметра> {OUT|IN OUT} [NOCOPY] <тип данных>

    <объявление_1> ::= { <объявление типа> | <объявление курсора> 
                       | <объявление переменных и констант>
                       | <объявление функции> | <объявление процедуры> }

    <объявление_2> ::= { <объявление курсора> | <создание курсора> | <объявление функции> 
                       | <реализация функции> | <объявление процедуры> | <реализация процедуры> }


Создание процедуры с IN параметрами
""""""""""""""""""""""""""""""""""""

.. list-table::
      :class: borderless
      
      * - :ess:`Oracle`
      
          .. code-block::
             :greenlines: 1, 2, 3, 4, 5, 6, 7, 8, 9
             
             CREATE [ OR REPLACE ] 
             PROCEDURE [ <схема>. ] <имя процедуры>
              [(<IN-параметр> [,<IN-параметр>...])] 
             [AUTHID { CURRENT_USER | DEFINER }]
             {IS|AS} 
                [ <объявление> [<объявление> ...] ] 
             BEGIN 
                <блок операторов> 
             END [ <имя процедуры> ] ;              
             
  	                                                        
        - :ess:`Rdb`
        
          .. code-block:: 
             :greenlines: 1, 2, 3, 4, 5, 6, 7, 8, 9
             
             CREATE [ OR ALTER ] 
             PROCEDURE <имя процедуры>
              [(<IN-параметр> [,<IN-параметр>...])]
             [SQL SECURITY {DEFINER | INVOKER}]
             AS
                [<объявление> [<объявление> ...] ]
             BEGIN
                <блок операторов>
             END ;

Создание процедуры с OUT параметрами
""""""""""""""""""""""""""""""""""""""""""    

Процедура с out-параметрами конвертируется в селективную процедуру, из которой можно получить out-параметры.
При конвертации:
Те же изменения, что и стандартной процедуре
Добавляется конструкция RETURNS <выходные параметры> 
Создается возвращаемый параметр,  который принимает тип входящего параметра исходной процедуры. 
В конце тела процедуры добавляется оператор SUSPEND


.. list-table::
      :class: borderless
      
      * - :ess:`Oracle`
      
          .. code-block::
             :greenlines: 1, 2, 3, 4, 5, 6, 7, 8, 9, 10
             
             CREATE [ OR REPLACE ] 
             PROCEDURE [ <схема>. ] <имя процедуры>
              (<OUT-параметр> [,<IN|OUT-параметр>...])

             [AUTHID { CURRENT_USER | DEFINER }]
             {IS|AS} 
                [ <объявление> [<объявление> ...] ] 
             BEGIN 
                <блок операторов> 
             END [ <имя процедуры> ] ;              
             
  	                                                        
        - :ess:`Rdb`
        
          .. code-block:: 
             :greenlines: 1, 2, 3, 4, 5, 6, 7, 8, 9, 10
             
             CREATE [OR ALTER] 
             PROCEDURE <имя процедуры> 
               (<OUT-параметр> [,<IN|OUT-параметр>...])
             RETURNS (<OUT-пар.>_OUT [,...]);
             [SQL SECURITY {DEFINER | INVOKER}]
             AS 
               [<объявление> [<объявление> ...] ]
             BEGIN
               <блок операторов>
             END ;


``ALTER PROCEDURE``
^^^^^^^^^^^^^^^^^^^^

.. code-block::
    :redlines:  1, 2, 3, 4
    :caption: Oracle
    
    ALTER PROCEDURE [<схема>.] <имя процедуры>
    { COMPILE [ DEBUG ] [ <параметры компиляции> ... ] [ REUSE SETTINGS ] 
    | { EDITIONABLE | NONEDITIONABLE } 
    }


``DROP PROCEDURE``
^^^^^^^^^^^^^^^^^^^^

.. list-table::
      :class: borderless
      
      * - :ess:`Oracle`
      
          .. code-block::
             :greenlines: 1
             
             DROP PROCEDURE [ <схема>. ] <имя процедуры> ;


        - :ess:`Rdb`
        
          .. code-block:: 
             :greenlines: 1
             
             DROP PROCEDURE <имя процедуры>;


.. _subsec:trigger:

Триггеры (``Trigger``)
--------------------------

``CREATE TRIGGER``
^^^^^^^^^^^^^^^^^^^^

.. code-block::
    :redlines:  2, 4, 5, 7, 8, 9, 12, 13, 14, 15, 17, 19, 25, 30, 36
    :greenlines: 1, 3, 6, 11, 16, 18, 20, 21, 22, 23, 24, 26, 27, 28, 29, 31, 32, 33, 34, 35, 38, 39, 41, 42
    :caption: Oracle
    
    CREATE [ OR REPLACE ] 
    [ EDITIONABLE | NONEDITIONABLE ]
    TRIGGER [<схема>.] <имя триггера>
    [ SHARING = { METADATA | NONE } ] 
    [ DEFAULT COLLATION <опция сортировки> ] 
    { <dml триггеры>
    | <dml триггеры с заменой для необновляемых представлений>
    | <составной dml триггер>
    | <системный триггер> }

    <dml триггеры> ::= { BEFORE | AFTER } <DML событие> 
                       [ REFERENCING { OLD [AS] <old> | NEW [AS] <new> | PARENT [AS] <parent>}... ] 
                       [ FOR EACH ROW ]
                       [ { FORWARD | REVERSE } CROSSEDITION ] 
                       [ { FOLLOWS | PRECEDES } [<схема>.] <имя триггера> [,...]]
                       [ ENABLE | DISABLE ] 
                       [ WHEN ( <условие> )] 
                       {
                         [ << label >> [ << label >> ]...] 
                         [ DECLARE {<объявление_1>;... [<объявление_2>;]... | <объявление_2>;...}] 
                         BEGIN 
                            <блок операторов>
                         [ EXCEPTION <exception_handler> [ <exception_handler> ]... ] 
                         END [ <имя триггера> ] ; 
                       | CALL <routine_clause> 
                       }                 
  
    <объявление_1> ::= { <объявление типа> | <объявление курсора> 
                       | <объявление переменных и констант>
                       | <объявление функции> | <объявление процедуры> }

    <объявление_2> ::= { <объявление курсора> | <создание курсора> | <объявление функции> 
                       | <реализация функции> | <объявление процедуры> | <реализация процедуры> }
                      


Создание DML триггеров
""""""""""""""""""""""""

.. list-table::
      :class: borderless
      
      * - :ess:`Oracle`
      
          .. code-block::
             :greenlines: 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11
             
             CREATE [ OR REPLACE ] 
             TRIGGER [<схема>.] <имя триггера>

             { BEFORE | AFTER } 
                  <DML событие> [OR <DML событие> ...]
             ON [<схема>.] { <таблица> | <представление> }
             [ ENABLE | DISABLE ] 
             [ DECLARE <объявление>;... ] 
             BEGIN 
                <блок операторов>
             END [ <имя триггера> ] ;


        - :ess:`Rdb`
        
          .. code-block:: 
             :greenlines: 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11
             
             CREATE [ OR ALTER ] 
             TRIGGER <имя триггера>
             [ACTIVE | INACTIVE]
             { BEFORE | AFTER } 
                  <DML событие> [OR <DML событие> ...]
             ON { <таблица> | <представление> }

             AS [<объявление>; ...]
             BEGIN
               <блок операторов>
             END;

             





``ALTER TRIGGER``
^^^^^^^^^^^^^^^^^^^^

.. list-table::
      :class: borderless
      
      * - :ess:`Oracle`
          
          .. code-block::
              :redlines: 2,3, 5, 6
              :greenlines: 1, 4, 7
              
              ALTER TRIGGER [<схема>. ] <имя триггера>
              { COMPILE [DEBUG] [<параметры компиляции>...] 
                [REUSE SETTINGS]
              | { ENABLE | DISABLE }
              | RENAME TO <новое имя>
              | { EDITIONABLE | NONEDITIONABLE }
              } ;

        - :ess:`Rdb`
        
          .. code-block:: 
             :greenlines: 1, 4
             
             ALTER TRIGGER <имя триггера>
             
             
             [ACTIVE | INACTIVE];


                                                         .


``DROP TRIGGER``
^^^^^^^^^^^^^^^^^^^^

.. list-table::
      :class: borderless
      
      * - :ess:`Oracle`
          
          .. code-block::
              :redlines: 2,3, 5, 6
              :greenlines: 1, 4, 7
              
              DROP TRIGGER [<схема>.] <имя триггера>;

        - :ess:`Rdb`
        
          .. code-block:: 
             :greenlines: 1, 4
             
             DROP TRIGGER <имя триггера>;


.. _subsec:package:

Заголовки пакетов (``Package``)
---------------------------------


``CREATE PACKAGE``
^^^^^^^^^^^^^^^^^^^^

.. code-block::
    :redlines:  2, 4, 5, 7, 12, 13, 17, 19, 20, 21, 24
    :greenlines: 1, 3, 6, 8, 9, 11, 15, 16, 18, 23
    :caption: Oracle
    
    CREATE [ OR REPLACE ] 
    [ EDITIONABLE | NONEDITIONABLE ]
    PACKAGE [<схема>.] <имя пакета> 
    [ SHARING = { METADATA | NONE } ] 
    [ { DEFAULT COLLATION <опция сортировки> 
      | AUTHID { CURRENT_USER | DEFINER } 
      | ACCESSIBLE BY ( <средство доступа> [, <средство доступа> ]... )}... ]  
    { IS | AS } <список объявлений> 
    END [<имя пакета>] ;

    <список объявлений> ::= { <объявление пак. функции> | <объявление пак. процедуры>
                            | <объявление типа> | <объявление курсора> 
                            | <объявление переменных и констант> } ...

    <объявление пак.функции> ::= FUNCTION <имя функции> [(<IN|OUT параметр>[,<IN|OUT параметр>])]
                                 RETURN <тип данных> 
                                 [ ACCESSIBLE BY (<средство доступа> [, <средство доступа> ]... ) 
                                 | DETERMINISTIC 
                                 | PIPELINED ... 
                                 | PARALLEL_ENABLE ...  
                                 | RESULT_CACHE ... ] ;

    <объявление пак.процедуры> ::= PROCEDURE <процедура> [(<IN|OUT параметр>[,<IN|OUT параметр>])] 
                                   [ACCESSIBLE BY (<средство доступа> [, <средство доступа> ]...)] ;

Создание пакета 
""""""""""""""""""

.. list-table::
      :class: borderless
      
      * - :ess:`Oracle`
          
          .. code-block::
              :greenlines: 1, 2, 3, 4, 5, 6, 7
              
              CREATE [ OR REPLACE ] 
              PACKAGE [<схема>.] <имя пакета>
              [AUTHID { CURRENT_USER | DEFINER }]
              { IS | AS } 
                 { <объявление процедуры>; 
                 | <объявление функции>; ...}
              END [<имя пакета>] ;

        - :ess:`Rdb`
        
          .. code-block:: 
             :greenlines: 1, 2, 3, 4, 5, 6, 7
             
             CREATE [ OR ALTER ]
             PACKAGE <имя пакета>
             [SQL SECURITY {DEFINER | INVOKER}]
             AS BEGIN
                { <объявление процедуры>;
                | <объявление функции>;...}
             END ; 


Объявление пакетной процедуры с IN параметрами
""""""""""""""""""""""""""""""""""""""""""""""""

.. list-table::
      :class: borderless
      
      * - :ess:`Oracle`
          
          .. code-block::
              :greenlines: 1, 2, 3, 4, 5,7,8,9
              
              CREATE [ OR REPLACE ] 
              PACKAGE [<схема>.] <имя пакета>
              [AUTHID { CURRENT_USER | DEFINER }]
              { IS | AS } 
                 PROCEDURE <имя> (<IN-пар.>[,<IN-пар.>]); 

                 [ <объявление процедуры>; 
                 | <объявление функции>;...]
              END [<имя пакета>] ;

        - :ess:`Rdb`
        
          .. code-block:: 
             :greenlines: 1, 2, 3, 4, 5, 7, 8, 9
             
             CREATE [ OR ALTER ]
             PACKAGE <имя пакета>
             [SQL SECURITY {DEFINER | INVOKER}]
             AS BEGIN
                PROCEDURE <имя> (<IN-пар.>[,<IN-пар.>]);

                [ <объявление процедуры>; 
                | <объявление функции>;...]
             END ; 



Объявление пакетной функции с IN параметрами
"""""""""""""""""""""""""""""""""""""""""""""

.. list-table::
      :class: borderless
      
      * - :ess:`Oracle`
          
          .. code-block::
              :greenlines: 1, 2, 3, 4, 5, 6, 7, 9, 10, 11
              
              CREATE [ OR REPLACE ] 
              PACKAGE [<схема>.] <имя пакета>
              [AUTHID { CURRENT_USER | DEFINER }]
              { IS | AS } 
                 FUNCTION <имя> (<IN-пар.>[,<IN-пар.>]...)
                   RETURN <тип данных> 
                   [DETERMINISTIC];

                 [ <объявление процедуры>; 
                 | <объявление функции>;...];
              END [<имя пакета>];

        - :ess:`Rdb`
        
          .. code-block:: 
             :greenlines: 1, 2, 3, 4, 5, 6, 7, 9, 10, 11
             
             CREATE [ OR ALTER ]
             PACKAGE <имя пакета>
             [SQL SECURITY {DEFINER | INVOKER}]
             AS BEGIN
                FUNCTION <имя> (<IN-пар.> [,<IN-пар.>...])
                  RETURNS <тип данных> 
                  [DETERMINISTIC];

                [ <объявление процедуры>; 
                | <объявление функции>;...]
             END ; 

Объявление функции с OUT параметрами
""""""""""""""""""""""""""""""""""""""

.. list-table::
      :class: borderless
      
      * - :ess:`Oracle`
          
          .. code-block::
              :redlines: 7
              :greenlines: 1, 2, 3, 4, 5, 6, 9, 10, 11
              
              CREATE [ OR REPLACE ] 
              PACKAGE [<схема>.] <имя пакета>
              [AUTHID { CURRENT_USER | DEFINER }]
              { IS | AS } 
              FUNCTION <имя> (<OUT-пар.>[,<IN|OUT-пар.>])
                RETURN <тип возвр.данных> 
                [DETERMINISTIC];

              [ <объявление процедуры>; 
              | <объявление функции>;...];
              END [<имя пакета>];

        - :ess:`Rdb`
        
          .. code-block:: 
             :greenlines: 1, 2, 3, 4, 5, 6, 7, 9, 10, 11
             
             CREATE [ OR ALTER ]
             PACKAGE <имя пакета>
             [SQL SECURITY {DEFINER | INVOKER}]
             AS BEGIN
             PROCEDURE <имя> (<OUT-пар.>[,<IN|OUT-пар.>]);
               RETURNS ( <имя перем.><тип возвр.данных>,
                         <OUT-пар.>_OUT ...);

             [ <объявление процедуры>; 
             | <объявление функции>;...]
             END ; 

Объявление процедуры с OUT параметрами
""""""""""""""""""""""""""""""""""""""""

.. list-table::
      :class: borderless
      
      * - :ess:`Oracle`
          
          .. code-block::
              :greenlines: 1, 2, 3, 4, 5, 8, 9, 10
              
              CREATE [ OR REPLACE ] 
              PACKAGE [<схема>.] <имя пакета>
              [AUTHID { CURRENT_USER | DEFINER }]
              { IS | AS } 
              PROCEDURE <имя> (<OUT-пар.>[,<IN|OUT-пар.>]); 


              [ <объявление процедуры>; 
              | <объявление функции>;...];
              END [<имя пакета>] ;

        - :ess:`Rdb`
        
          .. code-block:: 
             :greenlines: 1, 2, 3, 4, 5, 6, 8, 9, 10
             
             CREATE [ OR ALTER ]
             PACKAGE <имя пакета>
             [SQL SECURITY {DEFINER | INVOKER}]
             AS BEGIN
             PROCEDURE <имя> (<OUT-пар.>[,<IN|OUT-пар.>]);
               RETURNS (<OUT-пар.>_OUT [,...])

             [ <объявление процедуры>; 
             | <объявление функции>;...]
             END ; 





``ALTER PACKAGE``
^^^^^^^^^^^^^^^^^^

.. code-block::
    :redlines:  1, 2, 3
    :caption: Oracle

    ALTER PACKAGE [<схема>.] <имя пакета>
    { COMPILE [ DEBUG ] [ <параметры компиляции> ... ] [ REUSE SETTINGS ] 
    | { EDITIONABLE | NONEDITIONABLE } } ;


``DROP PACKAGE``
^^^^^^^^^^^^^^^^^

.. list-table::
      :class: borderless
      
      * - :ess:`Oracle`
          
          .. code-block::
              :greenlines: 1
              
              DROP PACKAGE [<схема>.] <имя пакета>;

        - :ess:`Rdb`
        
          .. code-block:: 
             :greenlines: 1
             
             DROP PACKAGE <имя пакета>;


.. _subsec:packagebody:

Тело пакетов (``Package Body``)
--------------------------------


``CREATE PACKAGE BODY``
^^^^^^^^^^^^^^^^^^^^^^^^^

.. code-block::
    :redlines:  2,7, 8, 9,10, 24, 25,26,   29,30,31,   36,37,38,39,   48,49,50,51
    :greenlines: 1, 3, 4, 5, 6, 11,   13,14,15,   17,18,19,   21,22,23,    28,   33,34,35,40,41,42,43,44,45,46,   47,52,53,54,55,56,57
    :caption: Oracle
    
    CREATE [ OR REPLACE ] 
    [ EDITIONABLE | NONEDITIONABLE ] 
    PACKAGE BODY [<схема>.] <имя пакета> 
    { IS | AS } 
      { <объявление_1>;... [<объявление_2>;]... 
      | <объявление_2>;... }   
    [ BEGIN 
      <блок операторов>
      [ EXCEPTION <exception_handler>... ]
    ]
    END [<имя пакета>] ;

    <объявление_1> ::= { <объявление функции> | <объявление процедуры>
                       | <объявление типа> | <объявление курсора> 
                       | <объявление переменных и констант> }

    <объявление_2> ::= { <объявление функции> | <реализация функции> 
                       | <объявление процедуры> | <реализация процедуры>
                       | <объявление курсора> | <создание курсора> }
    
    <объявление функции> ::= FUNCTION <имя функции> [(<IN|OUT параметр>[,<IN|OUT параметр>])]
                             RETURN <тип данных> 
                             [ DETERMINISTIC 
                             | PIPELINED 
                             | PARALLEL_ENABLE 
                             | RESULT_CACHE ]... ; 

    <объявление процедуры> ::= PROCEDURE <процедура> [(<IN|OUT параметр>[,<IN|OUT параметр>])] 
                               [ ACCESSIBLE BY (<средство доступа> [, <средство доступа> ]...)
                               | DEFAULT COLLATION <опция сортировки>
                               | AUTHID { CURRENT_USER | DEFINER }]... ;

    <реализация функции> ::= FUNCTION <имя функции> [(<IN|OUT параметр>[,<IN|OUT параметр>])]
                             RETURN <тип данных> 
                             [ DETERMINISTIC
                             | PIPELINED
                             | PARALLEL_ENABLE
                             | RESULT_CACHE [ RELIES_ON ...]  ]...
                             { { IS | AS } <внешний модуль>
                             | { IS | AS } [ <объявление_1>;... [<объявление_2>;]... 
                                           | <объявление_2>;... ] 
                             BEGIN
                                 <блок операторов> ...
                                 [ EXCEPTION <exception_handler> [ <exception_handler> ]... ]
                             END [<имя процедуры>] ; }

    <реализация процедуры> ::= PROCEDURE <процедура> [(<IN|OUT параметр>[,<IN|OUT параметр>])] 
                               [ ACCESSIBLE BY (<средство доступа> [, <средство доступа> ]...)
                               | DEFAULT COLLATION <опция сортировки>
                               | AUTHID { CURRENT_USER | DEFINER }]... 
                               { { IS | AS } <внешний модуль>
                               | { IS | AS } [ <объявление_1>;... [<объявление_2>;]... 
                                             | <объявление_2>;... ] 
                               BEGIN
                                    <блок операторов> ...
                                    [ EXCEPTION <exception_handler> [ <exception_handler> ]... ]
                               END [<имя процедуры>] ; }



Создание тела пакета 
"""""""""""""""""""""

.. list-table::
      :class: borderless
      
      * - :ess:`Oracle`
          
          .. code-block::
              :greenlines: 1, 2, 3, 4, 5, 6, 7, 8
              
              CREATE [ OR REPLACE ] 
              PACKAGE BODY [<схема>.] <имя пакета>
              { IS | AS }
                 [ <объявление процедуры>;
                 | <объявление функции>;...]
                 { <реализация процедуры>;
                 | <реализация функции>;...}
              END [<имя пакета>] ;

        - :ess:`Rdb`
        
          .. code-block:: 
             :greenlines: 1, 2, 3, 4, 5, 6, 7, 8
             
             RECREATE
             PACKAGE BODY <имя пакета>
             AS BEGIN
                [ <объявление процедуры>;
                | <объявление функции>;...]
                { <реализация процедуры>;
                | <реализация функции>;...}
             END ;


Реализация пакетной функции с IN параметрами
"""""""""""""""""""""""""""""""""""""""""""""

.. list-table::
      :class: borderless
      
      * - :ess:`Oracle`
          
          .. code-block::
              :greenlines: 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14
              
              CREATE [ OR REPLACE ] 
              PACKAGE BODY [<схема>.] <имя пакета>
              { IS | AS } 
                 FUNCTION <имя> (<IN-пар.>[,<IN-пар.>]...)
                   RETURN <тип данных> 
                   [DETERMINISTIC]
                 { IS | AS } [ <объявление>...]
                 BEGIN
                    <блок операторов> ...
                 END [<имя процедуры>] ; 

                 [ <объявление|реализация процедуры>; 
                 | <объявление|реализация функции>;...];
              END [<имя пакета>];

        - :ess:`Rdb`
        
          .. code-block:: 
             :greenlines: 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14
             
             RECREATE
             PACKAGE BODY <имя пакета>
             AS BEGIN
                FUNCTION <имя> (<IN-пар.> [,<IN-пар.>...])
                  RETURNS <тип данных> 
                  [DETERMINISTIC]
                AS [<объявление> ... ]
                BEGIN
                  <блок операторов>
                END ;

                [ <объявление|реализация процедуры>; 
                | <объявление|реализация функции>;...];
             END ; 


Реализация пакетной процедуры с IN параметрами
"""""""""""""""""""""""""""""""""""""""""""""""

.. list-table::
      :class: borderless
      
      * - :ess:`Oracle`
          
          .. code-block::
              :greenlines: 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12
              
              CREATE [ OR REPLACE ] 
              PACKAGE BODY [<схема>.] <имя пакета>
              { IS | AS } 
                 PROCEDURE <имя> (<IN-пар.>[,<IN-пар.>])
                 { IS | AS } [<объявление> ... ]
                 BEGIN
                   <блок операторов>
                 END  [<имя процедуры>] ;

                 [ <объявление|реализация процедуры>; 
                 | <объявление|реализация функции>;...];
              END [<имя пакета>] ;

        - :ess:`Rdb`
        
          .. code-block:: 
             :greenlines: 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12
             
             RECREATE
             PACKAGE BODY <имя пакета>
             AS BEGIN
                PROCEDURE <имя> (<IN-пар.>[,<IN-пар.>])
                AS [<объявление> ... ]
                BEGIN
                  <блок операторов>
                END ;

                [ <объявление|реализация процедуры>; 
                | <объявление|реализация функции>;...];
             END ; 


Реализация пакетной функции с OUT параметрами
"""""""""""""""""""""""""""""""""""""""""""""


.. list-table::
      :class: borderless
      
      * - :ess:`Oracle`
          
          .. code-block::
              :redlines: 7
              :greenlines: 1, 2, 3, 4, 5, 6, 8, 9, 10, 11, 12, 13, 14, 15
              
              CREATE [ OR REPLACE ] 
              PACKAGE BODY [<схема>.] <имя пакета>
              { IS | AS } 
                FUNCTION <имя> (<OUT-пар.>[,<IN|OUT-пар.>])
                RETURN <тип возвр.данных> 

                [DETERMINISTIC]
                { IS | AS } [<объявление> ... ]
                BEGIN
                   <блок операторов>
                END  [<имя процедуры>] ;

                [ <объявление|реализация процедуры>; 
                | <объявление|реализация функции>;...];
              END [<имя пакета>];

        - :ess:`Rdb`
        
          .. code-block:: 
             :greenlines: 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15
             
             RECREATE
             PACKAGE BODY <имя пакета>
             AS BEGIN
              PROCEDURE <имя> (<OUT-пар.>[,<IN|OUT-пар.>])
              RETURNS ( <имя перем.><тип возвр.данных>,
                        <OUT-пар.>_OUT ...)

              AS [<объявление> ... ]
              BEGIN
                 <блок операторов>
              END;

             [ <объявление|реализация процедуры>; 
             | <объявление|реализация функции>;...];
             END ; 



Реализация пакетной процедуры с OUT параметрами
"""""""""""""""""""""""""""""""""""""""""""""""

.. list-table::
      :class: borderless
      
      * - :ess:`Oracle`
          
          .. code-block::
              :greenlines: 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13
              
              CREATE [ OR REPLACE ] 
              PACKAGE BODY [<схема>.] <имя пакета>
              { IS | AS } 
              PROCEDURE <имя> (<OUT-пар.>[,<IN|OUT-пар.>])

              { IS | AS } [<объявление> ... ]
              BEGIN
                  <блок операторов>
              END  [<имя процедуры>] ;

              [ <объявление|реализация процедуры>; 
              | <объявление|реализация функции>;...];
              END [<имя пакета>] ;

        - :ess:`Rdb`
        
          .. code-block:: 
             :greenlines: 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13
             
             RECREATE
             PACKAGE BODY <имя пакета>
             AS BEGIN
             PROCEDURE <имя> (<OUT-пар.>[,<IN|OUT-пар.>])
             RETURNS (<OUT-пар.>_OUT [,...])
             AS [<объявление> ... ]
             BEGIN
                <блок операторов>
             END;

             [ <объявление|реализация процедуры>; 
             | <объявление|реализация функции>;...];
             END ; 



``DROP PACKAGE BODY``
^^^^^^^^^^^^^^^^^^^^^^^^^

.. list-table::
      :class: borderless
      
      * - :ess:`Oracle`
          
          .. code-block::
              :greenlines: 1
              
              DROP PACKAGE BODY [<схема>.] <имя пакета>;

        - :ess:`Rdb`
        
          .. code-block:: 
             :greenlines: 1
             
             DROP PACKAGE BODY <имя пакета>;




