/*CREATE [-unconvertible IMMUTABLE BLOCKCHAIN] TABLE immutable_blockchain_transactions (
    transaction_id NUMERIC(34, 8) GENERATED ALWAYS AS IDENTITY,
    transaction_date TIMESTAMP,
    amount NUMERIC(10,2),
    description VARCHAR(100)
) [-unconvertible NO DROP UNTIL 1 DAYS IDLE
NO DELETE UNTIL 16 DAYS AFTER INSERT
HASHING USING "SHA2_512" VERSION "v1"];*/