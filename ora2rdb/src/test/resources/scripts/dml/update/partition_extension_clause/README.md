Таблица котороая используется в тестах 

    CREATE TABLE "HR"."BOOKS"
    (
    "ISBN"       VARCHAR2(13) PRIMARY KEY,
    "TITLE"      VARCHAR2(100),
    "PAGE_COUNT" NUMBER
    )
    PARTITION BY RANGE ("PAGE_COUNT")
    (
    PARTITION books_small  VALUES LESS THAN (100),   
    PARTITION books_medium VALUES LESS THAN (300),   
    PARTITION books_large  VALUES LESS THAN (600),   
    PARTITION books_xlarge VALUES LESS THAN (MAXVALUE) );
    
    -----
    insert into books values ('9780321356680', 'Java', 659);
    
    insert into books values ('9780596009205', 'C++', 150);
    
    insert into books values ('9780134685991', 'Python', 320);


Для тестов на subpartition используется таблица 

    CREATE TABLE SALES
    (
        SALE_ID    NUMBER,
        PRODUCT_ID NUMBER,
        REGION     VARCHAR2(50),
        YEAR       NUMBER,
        AMOUNT     NUMBER
    )
    PARTITION BY RANGE (YEAR)
    SUBPARTITION BY LIST (REGION)
    (
    PARTITION sales_2022 VALUES LESS THAN (2023)
    (
        SUBPARTITION sales_2022_north VALUES ('North'),
        SUBPARTITION sales_2022_south VALUES ('South'),
        SUBPARTITION sales_2022_east  VALUES ('East'),
        SUBPARTITION sales_2022_west  VALUES ('West')
    ),
    PARTITION sales_2023 VALUES LESS THAN (2024)
    (
        SUBPARTITION sales_2023_north VALUES ('North'),
        SUBPARTITION sales_2023_south VALUES ('South'),
        SUBPARTITION sales_2023_east  VALUES ('East'),
        SUBPARTITION sales_2023_west  VALUES ('West')
    )
    );

    INSERT INTO SALES VALUES (1, 101, 'North', 2022, 1000);
    INSERT INTO SALES VALUES (2, 102, 'South', 2022, 1500);
    INSERT INTO SALES VALUES (3, 103, 'East',  2023, 2000);
    INSERT INTO SALES VALUES (4, 104, 'West',  2023, 2500);



