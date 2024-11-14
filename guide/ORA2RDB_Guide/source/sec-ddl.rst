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
    :caption: Oracle
    
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
             :addline:

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
                                                                  
                                                    
              :addline:
    

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
            :addline:
   
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
            :addline:
 

``ALTER TABLE``
^^^^^^^^^^^^^^^^

.. code-block::
    :redlines: 2, 3, 4, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 24, 25, 28, 29, 30, 34, 35
    :greenlines: 1, 5, 6, 19, 21, 22, 23, 26, 27, 31, 33, 36, 37
    :caption: Oracle
    
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

             :addline:

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






             :addline:


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



             :addline:



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
             :addline:


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









             :addline:


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









             :addline:  

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

Рассмотрим синтаксис создания индексов в СУБД Oracle [1]_:

.. color-block::
    :caption: Oracle
    
    :green:`CREATE [ UNIQUE` :red:`| BITMAP | MULTIVALUE` :green:`] INDEX` :red:`[<схема>.]` :green:`<имя индекса>`
    :red:`[ILM { ADD  POLICY [ <policy_clause> ]`
         :red:`| { DELETE | ENABLE | DISABLE } POLICY <имя политики>`  
         :red:`| { DELETE_ALL | ENABLE_ALL | DISABLE_ALL }`
         :red:`}` 
    :red:`]`
    :green:`ON { <табличный индекс>`
       :red:`| <bitmap индекс>`
       :red:`| <кластерный индекс>`       
       :green:`}`
    :green:`[ USABLE | UNUSABLE ]`
    :red:`[ { DEFERRED | IMMEDIATE } INVALIDATION ]` :green:`;` 

    :green:`<табличный индекс> ::=` :red:`[<схема>.]` :green:`<имя таблицы>` 
                           :red:`[ <алиас таблицы> ]`
                           :green:`( <выражение индекса> [ASC|DESC] [, <выражение индекса> [ASC|DESC]]...)`
                           :green:`[ TABLESPACE <имя табличного пространства> ]`
                           :green:`[ VISIBLE | INVISIBLE ]`
                           :red:`[ <другие атрибуты индекса> ]`


**Замечания**

- Ключевое слово ``BITMAP`` удаляется. В РБД используются индексы на основе B-деревьев.
- Индексы с ключевым словом ``MULTIVALUE`` комментируются. В текущей версии конвертера не поддерживается работа с типами JSON.
- Конструкция ``ILM ADD|DELETE POLICY ...`` удаляется.
- Выражения ``DEFERRED/IMMEDIATE INVALIDATION`` удаляются.
- Bitmap и кластерный индексы комментируются.


Преобразование ``CREATE INDEX``
""""""""""""""""""""""""""""""""

Далее рассмотрим только те конструкции оператора ``CREATE INDEX``, которые преобразуются 
конвертером и поддерживаются Ред Базой Данных.

Сравнение операторов создания табличного индекса [2]_:

.. list-table::
      :class: borderless
      
      * - :ess:`Oracle`
      
          .. code-block::
             :greenlines: 1, 2, 3, 4, 5, 6, 7, 8
              
             CREATE [UNIQUE] 
             INDEX <имя индекса> 
             ON <имя таблицы> 
             ( <столбец>|<выражение столбца> [ASC|DESC] 
               [, ...])
             [ TABLESPACE <имя табличного пространства> ]
             [ VISIBLE | INVISIBLE ]
             [ USABLE | UNUSABLE ];
                                                        
        - :ess:`Rdb`
        
          .. code-block:: 
             :greenlines: 1, 2, 3, 4, 5, 6, 7
             
             CREATE [UNIQUE] [ASC[ENDING] | DESC[ENDING]]
             INDEX <имя индекса> 
             ON <имя таблицы>
             { (<столбец> [, <столбец> …])
             | COMPUTED BY (<выражение столбца>) }
             [[IN] TABLESPACE <имя табл. пространства>];

             :addline:

.. warning::

  Поскольку в РБД при создании первичных, внешних ключей и ключей уникальности автоматически создаются одноименные индексы, 
  из входного скрипта Oracle необходимо исключить те команды ``CREATE INDEX``, которые явно создают те же самые индексы. 

  При конвертации оператора ``CREATE INDEX`` выполняются следующие задачи:  

1. *Преобразование ключевых слов* ``ASC|DESC``

   В РБД нет возможности указывать ключевые слова ``ASC|DESC`` для упорядочивания значений каждого столбца, зато есть
   возможность задать упорядочиваемость для совокупности столбцов, входящих в индекс. По умолчанию все индексы упорядочены по возрастанию
   значений столбцов (``ASC``). Если индекс создается по разнонаправленно упорядоченным столбцам, то конвертор создаст индекс 
   с направлением сортировки первого столбца:

   .. code-block:: sql
    :caption: Oracle
    
    CREATE INDEX index_name 
      ON table_name (column1 DESC, column2 ASC, column3 DESC);

   .. code-block:: sql
    :caption: to Rdb
    
    CREATE DESCENDING INDEX index_name 
      ON table_name (column1 /*DESC*/, column2 /*ASC*/, column3 /*DESC*/) IN TABLESPACE PRIMARY;


2. *Преобразование функциональных индексов (по выражению)*

   Если задано выражение для индекса, то при конвертации добавляется ключевое слово ``COMPUTED BY``. 
   
   .. code-block:: sql
    :caption: Oracle
    
    CREATE INDEX emp_total_sal_idx
      ON employees (12 * salary * commission_pct);

   .. code-block:: sql
    :caption: to Rdb
    
    CREATE INDEX emp_total_sal_idx_functional_1_ 
      ON employees COMPUTED BY (12 * salary * commission_pct) IN TABLESPACE PRIMARY;

   В РДБ есть возможность задать только одно выражение для индекса. Поэтому, если в Oracle индекс 
   создается по нескольким выражениям, то конвертор закомментирует индекс и предложит пользователю 
   самостоятельно его перестроить.

   В РБД существует два вида индексов: по столбцам и по выражению (вычисляемые), но не их комбинация. 
   Поэтому если индекс комбинированный: по столбцам и по выражению, то конвертор также закомментирует 
   индекс и предложит пользователю самостоятельно его перестроить.
   
   
3. *Преобразование правила добавления табличных пространств*

   .. unindented_list::

      - Если правило ``TABLESPACE`` не указано, база данных Oracle создаёт индекс в табличном пространстве по умолчанию 
        владельца схемы, содержащей индекс. В РБД в этом случае индекс будет создан в том же табличном пространстве, что и таблица.
        Поэтому при конвертации ``CREATE INDEX`` без ``TABLESPACE`` добавляется выражение ``IN TABLESPACE PRIMARY`` (в РБД), чтобы индекс 
        создался в основном файле базы данных (см. примеры выше).

      - Если в операторе указывается табличное пространство, куда нужно поместить индекс, то никаких преобразований не делается, 
        за исключением необязательной лексемы ``IN``.

        .. code-block:: sql
          :caption: Oracle
        
          CREATE INDEX emp_fname_uppercase_idx
            ON employees (UPPER(first_name)) TABLESPACE new_tablespace;

        .. code-block:: sql
          :caption: to Rdb
        
          CREATE INDEX emp_fname_uppercase_idx
            ON employees COMPUTED BY (UPPER(first_name)) IN TABLESPACE new_tablespace;
  

4. *Преобразование правила* ``VISIBLE | INVISIBLE``

   Данные ключевые слова используется в Oracle, чтобы указать будет ли индекс видимым или невидимым для оптимизатора.
   В РБД такие ключевые слова в операторе создания индекса отсутствуют. По умолчанию все индексы видимы и активны. 
   Поэтому при конвертации ключевое слово ``VISIBLE`` удаляется, а вместо ``INVISIBLE`` выполняется дополнительный оператор
   ``ALTER INDEX ... INACTIVE``, который отключает индекс.

   .. code-block:: sql
      :caption: Oracle
        
      CREATE INDEX emp_name_dpt_ix 
        ON hr.employees(last_name, department_id) INVISIBLE;

   .. code-block:: sql
      :caption: to Rdb
        
      CREATE INDEX emp_name_dpt_ix 
        ON employees(last_name, department_id) IN TABLESPACE PRIMARY;
      ALTER INDEX emp_name_dpt_ix INACTIVE;

5. *Преобразование правила* ``USABLE | UNUSABLE``

   Данные ключевые слова используется в Oracle, чтобы указать может он быть использован для доступа к данным или нет.
   По умолчанию все индексы - ``USABLE``. 
   В РБД такие ключевые слова в операторе создания индекса отсутствуют. 
   Поэтому при конвертации ключевое слово ``USABLE`` удаляется, а вместо ``UNUSABLE`` выполняется дополнительный оператор
   ``ALTER INDEX ... INACTIVE``, который отключает индекс.

   .. code-block:: sql
      :caption: Oracle
        
      CREATE INDEX emp_name_dpt_ix 
        ON hr.employees(last_name, department_id) UNUSABLE;

   .. code-block:: sql
      :caption: to Rdb
        
      CREATE INDEX emp_name_dpt_ix 
        ON employees(last_name, department_id) IN TABLESPACE PRIMARY;
      ALTER INDEX emp_name_dpt_ix INACTIVE;


``ALTER INDEX``
^^^^^^^^^^^^^^^^^^^^

Рассмотрим синтаксис изменения индексов в СУБД Oracle [3]_:

.. color-block::
    :caption: Oracle
    
    :green:`ALTER INDEX` :red:`[<схема>.]` :green:`<имя индекса>`
    :red:`[ILM { ADD  POLICY [ <policy_clause> ]`
         :red:`| { DELETE | ENABLE | DISABLE } POLICY <имя политики>`  
         :red:`| { DELETE_ALL | ENABLE_ALL | DISABLE_ALL }`
         :red:`}` 
    :red:`]`
    :green:`{` :red:`{ <предложение DEALLOCATE UNUSED>`
      :red:`| <предложение ALLOCATE EXTENT>`
      :red:`| SHRINK SPACE [ COMPACT ] [ CASCADE ]`
      :red:`| { NOPARALLEL | PARALLEL [<число>] }`
      :red:`| <физические атрибуты>`
      :red:`| { LOGGING | NOLOGGING |  FILESYSTEM_LIKE_LOGGING }`
      :red:`| INDEXING { PARTIAL | FULL }`
      :red:`} ...`
    :green:`| REBUILD [TABLESPACE <имя табл. пространства>` :red:`| <другие атрибуты rebuild>`:green:`]`
    :red:`| PARAMETERS ('ODCI_parameters')`
    :red:`| COMPILE`
    :green:`| { ENABLE | DISABLE }`
    :green:`| UNUSABLE` :red:`[ ONLINE ] [ { DEFERRED | IMMEDIATE } INVALIDATION ]`
    :green:`| {VISIBLE | INVISIBLE}`
    :red:`| RENAME TO <новое имя>`
    :red:`| COALESCE [ CLEANUP ] [ ONLY ] [ <предложение PARALLEL> ]`
    :red:`| { MONITORING | NOMONITORING } USAGE`
    :red:`| UPDATE BLOCK REFERENCES`
    :red:`| <предложение для секционированных индексов>`
    :green:`} ;`

**Замечания**

- Все неподдерживаемые конструкции удаляются


Преобразование ``ALTER INDEX``
""""""""""""""""""""""""""""""""

Далее рассмотрим только те конструкции оператора ``ALTER INDEX``, которые преобразуются 
конвертером и поддерживаются Ред Базой Данных.

Сравнение операторов изменения табличного индекса:

.. list-table::
      :class: borderless
      
      * - :ess:`Oracle`
      
          .. code-block::
             :greenlines: 1, 2, 3, 4, 5, 6

             ALTER INDEX <имя индекса>
             { { ENABLE | DISABLE }
             | { VISIBLE | INVISIBLE }
             | REBUILD 
               [TABLESPACE <имя табл.прост-ва>]
             };
                                                        
        - :ess:`Rdb`
        
          .. code-block:: 
             :greenlines: 1, 2, 3, 4, 5, 6
             
             ALTER INDEX <имя индекса> 
             { {ACTIVE | INACTIVE}

             | SET TABLESPACE [TO] { <имя табл.прост-ва> 
                                   | PRIMARY}
             };                                  


При конвертации оператора ``ALTER INDEX`` выполняются следующие задачи:  

1. *Преобразование ключевых слов* ``ENABLE | DISABLE``

   Ключевые слова ``ENABLE/DISABLE`` применяются только к вычисляемому индексу, 
   они разрешают или запрещают использование индекса.
   При конвертации ``ENABLE`` заменяется на ``ACTIVE``, только если индекс имеет видимость ``VISIBLE``.
   Ключевое слово ``DISABLE`` заменяется на ``INACTIVE``.

   .. code-block:: sql
      :caption: Oracle
        
      ALTER INDEX emp_fname_uppercase_idx DISABLE;

   .. code-block:: sql
      :caption: to Rdb
        
      ALTER  INDEX emp_fname_uppercase_idx INACTIVE;

2. *Преобразование ключевого слова* ``UNUSABLE``

   Если индекс не пригоден для использования, он получает статус ``UNUSABLE``. Соответствено он не используется в запросах.
   Это правило заменяется на ``INACTIVE``.

   .. code-block:: sql
      :caption: Oracle
        
      ALTER INDEX emp_fname_uppercase_idx UNUSABLE;

   .. code-block:: sql
      :caption: to Rdb
        
      ALTER  INDEX emp_fname_uppercase_idx INACTIVE;
   

3. *Преобразование ключевых слов* ``VISIBLE | INVISIBLE``

   Данные ключевые слова используется в Oracle, чтобы указать будет ли индекс видимым или невидимым для оптимизатора.
   В РБД вместо них используются ключевые слова ``ACTIVE/INACTIVE``, которые включают/отключают индекс.

   .. code-block:: sql
      :caption: Oracle
        
      ALTER INDEX emp_name_dpt_ix VISIBLE;

   .. code-block:: sql
      :caption: to Rdb
        
      ALTER INDEX emp_name_dpt_ix ACTIVE;

4. *Преобразование правила* ``REBUILD``

   Данное правило пересоздаёт существующий индекс. 
   
   Если индекс имеет видимость ``VISIBLE``, то для РБД аналогичным действием будет оператор ``ACTIVE``.
   Если индекс невидим оптимизатору, то весь оператор удаляется.

   .. code-block:: sql
      :caption: Oracle
        
      ALTER INDEX emp_name_dpt_ix REBUILD;

   .. code-block:: sql
      :caption: to Rdb
        
      ALTER INDEX emp_name_dpt_ix ACTIVE;
   
5. *Преобразование правила* ``REBUILD TABLESPACE``

   Это правило пересоздает существующий индекс в новом табличном пространстве. Аналогичная конструкция есть в РБД, после которой
   (если индекс - ``VISIBLE``) добавляется оператор на переактивацию индекса.

   .. code-block:: sql
      :caption: Oracle
        
      ALTER INDEX emp_name_dpt_ix REBUILD TABLESPACE ts_name;

   .. code-block:: sql
      :caption: to Rdb
        
      ALTER INDEX emp_name_dpt_ix SET TABLESPACE TO ts_name;
      ALTER INDEX emp_name_dpt_ix ACTIVE;

   Если индекс имеет статус ``INVISIBLE``, то оператор "``ALTER INDEX ... ACTIVE;``" опускается.



``DROP INDEX``
^^^^^^^^^^^^^^^


.. list-table::
      :class: borderless
      
      * - :ess:`Oracle`
      
          .. color-block::
             
             :green:`DROP INDEX` :red:`[<схема>.]` :green:`<имя индекса>`
             :red:`[ONLINE] [FORCE]`
             :red:`[{DEFERRED|IMMEDIATE} INVALIDATION]`:green:`;`
                                                        
        - :ess:`Rdb`
        
          .. code-block:: 
            :greenlines: 1
             
            DROP INDEX <имя индекса>;

            :addline:


.. _subsec:view:

Представления (``View``)
--------------------------

``CREATE VIEW``
^^^^^^^^^^^^^^^^^^^^

Рассмотрим синтаксис изменения индексов в СУБД Oracle [4]_:

.. color-block::
    :caption: Oracle
    
    :green:`CREATE [OR REPLACE] [[NO] FORCE]` :red:`[ EDITIONING | EDITIONABLE [ EDITIONING ] | NONEDITIONABLE ]`
    :green:`VIEW` :red:`[<схема>.]` :green:`<имя представления>`
    :red:`[ SHARING = { METADATA | DATA | EXTENDED DATA | NONE } ]`
    :green:`[ ( { <алиас>` :red:`[ VISIBLE | INVISIBLE ] [ <ограничение строки>... ]`
        :red:`| <ограничение представления>` :green:`}`
        :green:`[, <алиас>... ]`
      :green:`)`
    :red:`| <предложение для объектного представления>`
    :red:`| <предложение для XMLType представления>`
    :green:`]`
    :red:`[ DEFAULT COLLATION <сортировка> ]`
    :red:`[ BEQUEATH { CURRENT_USER | DEFINER } ]`
    :green:`AS <оператор SELECT>` 
    :green:`[ {WITH CHECK OPTION | WITH READ ONLY}` :red:`[CONSTRAINT <имя ограничения>]` :green:`]`
    :red:`[ CONTAINER_MAP | CONTAINERS_DEFAULT ]` :green:`;`

**Замечания**

- При конвертации удаляются ключевые слова ``EDITIONING, EDITIONABLE, NONEDITIONABLE``.
- Удаляется конструкция ``SHARING``.
- Не конвертируются объектные представления и XMLType-представления.
- Ограничения строки и ограничения представления комментируются. 
- Атрибуты ``VISIBLE/INVISIBLE`` комментируются.
- Предложение ``DEFAULT COLLATION`` удаляется.
- Предложение ``BEQUEATH {CURRENT_USER|DEFINER}`` комментируется.

  Это правило определяет с каким правами: создателя (``DEFINER``) или вызывающего пользователя (``CURRENT_USER``) 
  будут вызываться функции внутри представления.
  По умолчанию в Oracle и РБД представления вызываются с правами владельца.
  Подобной конструкции в РБД нет, поэтому не получится изменить поведения по умолчанию. 

  .. warning::

   Если при создании функции (которая используется в представлении) указывается, что она должна вызываться с правами ``CURRENT_USER``,
   и при создании представления указывается ``BEQUEATH CURRENT_USER``, то такой случай не имеет аналогов в РБД.
   Во всех остальных случаях функции внутри представления будут вызываться с правами создателя.

- Предложение ``CONTAINER_MAP/CONTAINERS_DEFAULT`` удаляется.


Преобразование ``CREATE VIEW``
""""""""""""""""""""""""""""""""

Далее рассмотрим только те конструкции оператора ``CREATE VIEW``, которые преобразуются 
конвертером и поддерживаются Ред Базой Данных.

Сравнение операторов создания представления:

.. list-table::
      :class: borderless
      
      * - :ess:`Oracle`
          
          .. code-block::
             :greenlines: 1,2,3,4,5,6
             
             CREATE [OR REPLACE] [[NO] FORCE] 
             VIEW <имя представления> 
             [( <алиас> [, <алиас>...] )]
             AS <оператор SELECT>
             [ { WITH CHECK OPTION 
               | WITH READ ONLY } ]
  	                                                        
        - :ess:`Rdb`
        
          .. code-block:: 
             :greenlines: 1,2,3,4,5
             
             CREATE [OR ALTER] 
             VIEW <имя представления> 
             [( <алиас> [, <алиас>...] )]
             AS <оператор SELECT>
             [WITH CHECK OPTION]
             :addline:


При конвертации оператора ``CREATE VIEW`` выполняются следующие задачи:  

1. *Замена ключевого слова* ``OR REPLACE``

   Данное ключевое слово заменяется на равнозначное ему ``OR ALTER`` 
2. *Добавление правила* ``FORCE``
   
   В Oracle опция ``FORCE`` используется, чтобы принудительно создать представление, 
   использующее объекты, которые не были созданы ранее. В РБД это ключевое слово отсутствует, поэтому 
   при создании представлений проверка зависимостей выполняется всегда. Данную проблему можно решить, 
   если в процессе преобразования упорядочить операторы создания объектов таким образом, чтобы при 
   их выполнении не возникало ошибки об отсутствующем объекте БД. Чтобы этого добиться, при запуске 
   конвертера необходимо указать ключ "``-r``" , который изменяет порядок создания объектов (см. :ref:`sec:install`). 
3. *Преобразование правила* ``WITH READ ONLY``

   Эта опция запрещает операции обновления, удаления и вставки данных базовой таблицы через это представление.
   В РБД подобной опции нет, но при конвертации вместо неё создается триггер, который при попытке 
   вставки/удаления/изменения представление выкидывает исключение.

   .. code-block:: sql
      :caption: Oracle
        
      CREATE OR REPLACE FORCE VIEW VTAPP.CF_REP_CUSTOMER (CUSTOMER, DESCRIPTION, OBJKEY, OBJVERSION, OBJID)
      BEQUEATH DEFINER
      AS 
        SELECT
          customer                       customer,
          description                    description,
          rowkey                         objkey,
          to_char(rowversion,'YYYYMMDDHH24MISS') objversion,
          rowid                          objid
        FROM cf_rep_customer_tab
      WITH READ ONLY;

   .. code-block:: sql
      :caption: to Rdb
        
      CREATE EXCEPTION READ_ONLY_VIEW 'cannot perform a DML operation on a read-only view';

      CREATE OR ALTER VIEW CF_REP_CUSTOMER (CUSTOMER, DESCRIPTION, OBJKEY, OBJVERSION, OBJID) 
      /* BEQUEATH DEFINER */  
      AS
        SELECT
          customer                       customer,
          description                    description,
          rowkey                         objkey,
          UPPER( CAST(rowversion AS VARCHAR(32765) FORMAT'YYYYMMDDHH24MISS')) objversion,
          rowid                          objid
        FROM cf_rep_customer_tab ;

      CREATE TRIGGER CF_REP_CUSTOMER_READ_ONLY_TRIGGER FOR CF_REP_CUSTOMER
      BEFORE INSERT OR UPDATE OR DELETE
      AS BEGIN
        EXCEPTION READ_ONLY_VIEW
      END;


 



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
             :addline:






.. [1]
   Конструкции операторов Oracle, которые преобразуются конвертером (с учетом разницы в синтаксисе) обозначены :green:`зеленым` цветом.
   :red:`Красным` цветом обозначены конструкции, которые не поддерживаются Ред Базой Данных или конвертером. Неподдерживаемые конструкции
   удаляются или комментируются.


.. [2] 
   Для Ред Базы Данных представлен не полный синтаксис оператора, а только те конструкции, которые соответствуют синтаксису Oracle и конвертируются в них.


.. [3]
   Конструкции операторов Oracle, которые преобразуются конвертером (с учетом разницы в синтаксисе) обозначены :green:`зеленым` цветом.
   :red:`Красным` цветом обозначены конструкции, которые не поддерживаются Ред Базой Данных или конвертером. Неподдерживаемые конструкции
   удаляются или комментируются.


.. [4]
   Конструкции операторов Oracle, которые преобразуются конвертером (с учетом разницы в синтаксисе) обозначены :green:`зеленым` цветом.
   :red:`Красным` цветом обозначены конструкции, которые не поддерживаются Ред Базой Данных или конвертером. Неподдерживаемые конструкции
   удаляются или комментируются.