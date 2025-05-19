MERGE INTO bonuses t
   USING bonuses2 s
   ON (t.employee_id = s.employee_id)
    WHEN MATCHED THEN UPDATE SET t.bonus = t.bonus + s.bonus;