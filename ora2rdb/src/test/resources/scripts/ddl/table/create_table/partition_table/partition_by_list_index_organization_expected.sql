/*CREATE TABLE sales(acct_no NUMERIC(5),
                   acct_name CHAR(30),
                   amount_of_sale NUMERIC(6),
                   week_no INTEGER,
                   sale_details VARCHAR(1000),
             PRIMARY KEY (acct_no, acct_name, week_no))
    [-unconvertible ORGANIZATION INDEX
             INCLUDING week_no
             OVERFLOW TABLESPACE ts1
     PARTITION BY LIST (week_no)
            (PARTITION VALUES (1, 2, 3, 4)
                   TABLESPACE ts2,
             PARTITION VALUES (5, 6, 7, 8)
                   TABLESPACE ts3 OVERFLOW TABLESPACE ts4,
             PARTITION VALUES (DEFAULT)
                   TABLESPACE ts5)];*/