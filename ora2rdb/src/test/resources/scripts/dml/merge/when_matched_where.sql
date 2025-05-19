MERGE INTO bonuses t
   USING bonuses2 s
   ON (t.employee_id = s.employee_id)
    WHEN MATCHED THEN UPDATE SET bonus = DEFAULT
    WHERE s.employee_id < 159;
