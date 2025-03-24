## Ora2rdb 

Ora2rdb - Oracle to Red Database schema converter

### Description

Ora2rdb is a free tool used to migrate an Oracle database to a Red Database(RDB) schema.
It gets the structure of Oracle Database schema, then generates SQL scripts that you can load into your RDB database. 

### Features

Ora2rdb uses [ANTLR](https://www.antlr.org/) to analyze the input PL/SQL script. 
As an input grammar Ora2rdb takes [Grammars-v4](http://git.red-soft.biz/red-database/utils/grammars-v4). This is a collection 
of formal grammars written for ANTLR v4. 


### Installation

Ora2rdb requires at least a Java 8 JDK installed and maven.
To build a project you need create a jar file:

    $ mvn package

To run Ora2rdb go to target directory

    $ cd modules/ora2rdb/target

And run:

    $ java -jar Ora2rdb.jar 

### How to use

There is how to use Ora2rdb converter. 

    ora2rdb.jar <input_file> [options]

    Options:
        -o <output_file>    Specify output file 
        -r                  Reorder CREATE VIEW statements in according to their
                            dependencies. It allows to perform FORCE clause
                            conversion. Use this option only for scripts which
                            contain database metadata.
