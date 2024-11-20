CREATE VIEW oe.people_reltab_mv
   AS SELECT * FROM oe.people_reltab@orc1.example.com;
/* или не конвертируем */