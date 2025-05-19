/*CREATE [-unconvertible SHARDED] TABLE Customers(
    CustNo      NUMERIC(34, 8) NOT NULL,
    Name        VARCHAR(50)
)
[-unconvertible PARTITION BY CONSISTENT HASH (CustNo)
PARTITIONS AUTO]
[-unconvertible TABLESPACE SET ts1];*/