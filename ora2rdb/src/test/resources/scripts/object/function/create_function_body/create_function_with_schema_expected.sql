CREATE OR ALTER FUNCTION /*"GZVLG".*/"CURRENT_TRANSACTION_ID"
    RETURNS VARCHAR(32765) as
begin
    return dbms_transaction.local_transaction_id(TRUE);
end;