### Синтаксис create package

```sql
CREATE [OR REPLACE] [EDITIONABLE | NONEDITIONABLE] PACKAGE [schema_name.]<package_name>
[SHARING={METADATA | NONE}]
[DEFAULT COLLATION <collation_option>]
[AUTHID {DEFINER | CURRENT_USER}]
[ACCESSIBLE BY (<accessor>[, <accessor> ...])]
{IS | AS}
    [<declaration_block>]
END [<package_name>];

<accessor> ::= 
    [FUNCTION | PROCEDURE | PACKAGE | TRIGGER | TYPE] [<schema_name>.] <unit_name>   


```
declaration_block - описан в директории declaration_block
Синтаксис взят с [официальной документации Oracle](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/lnpls/CREATE-PACKAGE-statement.html)

----------------------------------------------------------------

### [create_editionable_noneditionable_package.sql](create_editionable_noneditionable_package.sql)

```sql
EDITIONABLE | NONEDITIONABLE
```  

Параметры `EDITIONABLE` и `NONEDITIONABLE` используются для управления версионированием объектов  
базы данных в контексте технологии Edition-Based Redefinition (EBR).  
`EDITIONABLE`:

* Указывает, что объект поддерживает версии (editions).
* Если объект является EDITIONABLE, его можно модифицировать или переопределять в новой редакции базы данных (edition),
  не затрагивая другие редакции. Значение по умолчанию: `EDITIONABLE`

`NONEDITIONABLE`:

* Указывает, что объект не поддерживает версии (editions).
* Объект NONEDITIONABLE существует в единственной версии в базе данных. Если его изменить, изменения будут видны всем
  пользователям независимо от текущей редакции.

----------------------------------------------------------------

### [create_or_replace_package.sql](create_or_replace_package.sql)

```sql
CREATE [OR REPLACE]
```

Указывает, что, если пакет уже существует, он будет заменен.
Если не указано, создание пакета вызовет ошибку, если пакет с таким именем существует.

----------------------------------------------------------------

### [create_package_accessible_by.sql](create_package_accessible_by.sql)
```sql
[ACCESSIBLE BY (<accessor>[, <accessor>...])]

<accessor> ::= 
    [FUNCTION | PROCEDURE | PACKAGE | TRIGGER | TYPE] [<schema_name>.] <unit_name>   
```
Указывает модуль PL/SQL, который может вызывать сущность.
Каждый accessor определяет сущность PL/SQL, которая имеет доступ к сущности.
Сущность, указанная в accessor, не обязательно должна существовать.
Любой вызов процедуры спецификации пакета или тела пакета будет проверяться по списку методов доступа спецификации пакета.

----------------------------------------------------------------

### [create_package_authid_clauses.sql](create_package_authid_clauses.sql)

```sql
AUTHID {DEFINER | CURRENT_USER}
```

`DEFINER`: Пакет выполняется с правами владельца (создателя), является значением по умолчанию.

`CURRENT_USER`: Пакет выполняется с правами текущего пользователя.


----------------------------------------------------------------

### [create_package_default_collation.sql](create_package_default_collation.sql)

```sql
[DEFAULT COLLATION <collation_option>]
```
`DEFAULT COLLATION` может встречаться в следующих операторах SQL:
* CREATE FUNCTION Statement
* CREATE PROCEDURE Statement
* CREATE PACKAGE Statement
* CREATE TRIGGER Statement
* CREATE TYPE Statement

Значение по умолчанию `USING_NLS_COMP`
Для того чтобы объявления сортировки были разрешены в операторах SQL параметр `COMPATIBLE` должен быть установлен как минимум на `12.2.0` и `MAX_STRING_SIZE` должен быть установлен на `EXTENDED`.  
Сортировка по умолчанию для процедуры, функции, пакета, типа или триггера должна быть `USING_NLS_COMP`.
Если результирующая сортировка объектов по умолчанию отличается от USING_NLS_COMP, объект базы данных создается как недопустимый с ошибкой компиляции.
Его нельзя указать для вложенных или пакетных подпрограмм, или для методов типа.

----------------------------------------------------------------

### [create_package_is_as.sql](create_package_is_as.sql)

```sql
IS | AS
```
IS и AS взаимозаменяемы и не влияют на поведение.
В RDB есть только AS, поэтому IS заменяется на AS при конвертации.

----------------------------------------------------------------

### [create_package_schema.sql](create_package_schema.sql)

```sql
[schema_name.]<package_name>
```
Указывает имя схемы, в которой создается пакет.

----------------------------------------------------------------

### [create_package_sharing.sql](create_package_sharing.sql)

```sql
[SHARING={METADATA | NONE}]
```
`METADATA` - Указывает, что объект доступен для всех контейнеров, но разделяется только метаданные объекта

`NONE` - Объект не является общим.

Параметр `SHARING` может появляться только в контексте создания общего объекта приложения со следующими операторами SQL:

* `CREATE FUNCTION Statement`
* `CREATE LIBRARY Statement`
* `CREATE PROCEDURE Statement`
* `CREATE PACKAGE Statement`
* `CREATE TRIGGER Statement`
* `CREATE TYPE Statement`

----------------------------------------------------------------

### [create_package_without_end_package_name.sql](create_package_without_end_package_name.sql)

Указание имени пакета в END является необязательным.

```sql
END [package_name];
```

----------------------------------------------------------------