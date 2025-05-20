CREATE MATERIALIZED VIEW oe.people_reltab_mv
   NESTED TABLE phones_ntab STORE AS phone_store_ntab_mv
   AS SELECT * FROM oe.people_reltab@orc1.example.com;
