/*
 https://docs.oracle.com/cd/E11882_01/appdev.112/e41502/adfns_editions.htm#ADFNS918:~:text=about%20using%20hints-,Crossedition%20Triggers,-The%20most%20important
 */
CREATE OR REPLACE TRIGGER trigger1
  BEFORE INSERT OR UPDATE ON table1
             FOR EACH ROW
             CROSSEDITION
DECLARE
row_already_present  EXCEPTION;
  PRAGMA EXCEPTION_INIT(row_already_present, -38911);
BEGIN
  IF APPLYING_CROSSEDITION_TRIGGER THEN
    /* Trigger is running because of serendipitous change.
       Insert new row into table2 unless it is already there. */
    INSERT /*+ IGNORE_ROW_ON_DUPKEY_INDEX(table2(key)) */
    INTO table2
    VALUES(:new.key, :new.value, to_date('1900-01-01', 'YYYY-MM-DD'));
ELSE
    /* Trigger is running because you are applying transform.
       If tranform has not yet inserted new row in table2, insert new row;
       otherwise, update new row. */
BEGIN
INSERT /*+ CHANGE_DUPKEY_ERROR_INDEX(table2(key)) */
INTO table2
VALUES(:new.key, :new.value, SYSTIMESTAMP);
EXCEPTION WHEN row_already_present THEN
UPDATE table2
SET value = :new.value, last_updated = SYSTIMESTAMP
WHERE key = :new.key;
END;
END IF;
END;
/