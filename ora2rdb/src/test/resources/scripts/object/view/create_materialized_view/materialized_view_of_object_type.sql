CREATE MATERIALIZED VIEW oe.cust_address_objtab_mv OF oe.cust_address_typ AS
SELECT * FROM oe.cust_address_objtab@orc1.example.com;
