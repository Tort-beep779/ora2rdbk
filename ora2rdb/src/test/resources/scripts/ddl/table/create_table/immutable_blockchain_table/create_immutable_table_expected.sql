/*CREATE [-unconvertible IMMUTABLE] TABLE immutable_blockchain_transactions (
    transaction_id NUMERIC(34, 8) GENERATED ALWAYS AS IDENTITY,
    amount NUMERIC(10,2),
    description VARCHAR(100)
) [-unconvertible NO DROP UNTIL 1 DAYS IDLE
  NO DELETE UNTIL 16 DAYS AFTER INSERT
  INMEMORY];*/