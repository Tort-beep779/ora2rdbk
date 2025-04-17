/*CREATE TABLE accounts
( id             NUMERIC(34, 8)
 , account_number NUMERIC(34, 8)
 , customer_id    NUMERIC(34, 8)
 , balance        NUMERIC(34, 8)
 , branch_id      NUMERIC(34, 8)
 , region         VARCHAR(2)
 , status         VARCHAR(1)
)
[-unconvertible PARTITION BY LIST (region)
SUBPARTITION BY HASH (customer_id) SUBPARTITIONS 8
( PARTITION p_northwest VALUES ('OR', 'WA')
 , PARTITION p_southwest VALUES ('AZ', 'UT', 'NM')
 , PARTITION p_northeast VALUES ('NY', 'VM', 'NJ')
 , PARTITION p_southeast VALUES ('FL', 'GA')
 , PARTITION p_northcentral VALUES ('SD', 'WI')
 , PARTITION p_southcentral VALUES ('OK', 'TX')
)];*/