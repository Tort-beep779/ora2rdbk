/*CREATE TABLE sales_by_region_and_channel
 (deptno           NUMERIC(34, 8),
  deptname         VARCHAR(20),
  quarterly_sales  NUMERIC(10,2),
  state            VARCHAR(2),
  channel          VARCHAR(1)
 )
  [-unconvertible PARTITION BY LIST (state, channel)
 (
  PARTITION q1_northwest_direct VALUES (('OR','D'), ('WA','D')),
  PARTITION q1_northwest_indirect VALUES (('OR','I'), ('WA','I')),
  PARTITION q1_southwest_direct VALUES (('AZ','D'),('UT','D'),('NM','D')),
  PARTITION q1_ca_direct VALUES ('CA','D'),
  PARTITION rest VALUES (DEFAULT)
 )];*/