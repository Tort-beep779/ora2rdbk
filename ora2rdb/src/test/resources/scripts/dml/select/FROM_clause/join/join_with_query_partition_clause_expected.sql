/* Can not convert this clause: partition by (cod)*/
SELECT * FROM PEOPLE [-unconvertible partition by (cod)] JOIN STAFF ON PEOPLE.COD = STAFF.CODPEOPLE;
