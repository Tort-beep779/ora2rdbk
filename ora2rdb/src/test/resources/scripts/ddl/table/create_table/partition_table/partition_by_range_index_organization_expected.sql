/*CREATE TABLE sales(acct_no NUMERIC(5),
                   acct_name CHAR(30),
                   amount_of_sale NUMERIC(6),
                   week_no INTEGER,
                   sale_details VARCHAR(1000),
             PRIMARY KEY (acct_no, acct_name, week_no))
     [-unconvertible ORGANIZATION INDEX
             INCLUDING week_no
             OVERFLOW TABLESPACE overflow_here
     PARTITION BY RANGE (week_no)
            (PARTITION VALUES LESS THAN (5)
                   TABLESPACE ts1,
             PARTITION VALUES LESS THAN (9)
                   TABLESPACE ts2 OVERFLOW TABLESPACE overflow_ts2,
             PARTITION VALUES LESS THAN (MAXVALUE)
                   TABLESPACE ts13)];*/