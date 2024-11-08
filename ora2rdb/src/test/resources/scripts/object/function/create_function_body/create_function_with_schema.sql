CREATE OR REPLACE FUNCTION "GZVLG"."CURRENT_TRANSACTION_ID"
    return varchar2 as
begin
    return dbms_transaction.local_transaction_id(TRUE);
end;